#import "BoardGameViewController.h"

#import "Facebook.h"

@implementation BoardGameViewController

@synthesize gameLogic = _gameLogic;
@synthesize logic = _logic;

#pragma mark -
#pragma mark Initialization

-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<BoardGameViewControllerDelegate>)delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    
    if(self == nil) return nil;
    
    _delegate = delegate;
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // attempts 
    _attemptsLeftView = [[NumberView alloc] initWithPosition:CGPointMake(450, 0) andNumber:0];
    [self.view addSubview:_attemptsLeftView];
}






#pragma mark -
#pragma mark Public Methods

-(void)startNewGame
{
    [_gameLogic startGameWithCorrectCards:[GameSettings numberOfCorrectCards]
                           winProbability:[GameSettings winProbability]
                            numberOfCards:[GameSettings numberOfCards] 
                           andMaxAttempts:[GameSettings maxAttempts]];
}



-(void)setBoardConfigPList:(NSString *)configFileName
{
    [[BoardConfig sharedInstance] loadConfig:configFileName];   
    
    [self startNewGame];
}






#pragma mark -
#pragma mark Events

-(IBAction) click
{    
    [self startNewGame];
}



-(IBAction)backToMenuClick:(id)sender
{
    [_delegate backToMenu];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsLandscape(orientation);
}





#pragma mark -
#pragma mark Game Logic Delegate

-(void)dealCards
{
    // dispose last set of cards
    for (int i=0;i<MAX_PLAYING_CARDS;i++) {
        if(_cards[i] != nil)
        {
            [_cards[i] removeFromSuperview];
            [_cards[i] release];
            _cards[i] = nil;
        }
    }
    
    int numberOfCards = [GameSettings numberOfCards];
    
    [[BoardConfig sharedInstance] restartDealingCards]; // to start a new set
    
    for(int i=0;i<numberOfCards;i++)
    {
        if(_cards[i] == nil)
            _cards[i] = [[PlayingCardView alloc] initWithPosition:CGPointMake(450, 100) index:i andDelegate:self];
        
        [self.view addSubview:_cards[i]];
    }
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"slot_map" ofType:@"plist"];
	NSDictionary * config = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSArray * slots = [config objectForKey:@"slots"];
    NSMutableArray * xs = [[NSMutableArray alloc] init];
    NSMutableArray * ys = [[NSMutableArray alloc] init];
    
    for(NSDictionary * slot in slots)
    {
        [xs addObject:[slot objectForKey:@"x"]];
        [ys addObject:[slot objectForKey:@"y"]];
    }
    
    NSMutableArray  * occupiedSlots = [[NSMutableArray alloc] init];

    
    
    
    // for landscape mode
    //int height = 768;//self.view.frame.size.width;
    //int width = 1024;//self.view.frame.size.height;
    
    
    //int position_x_offset = width / (numberOfCards + 1);
    
    for(int i=0;i<numberOfCards;i++)
    {
        int slotNumber;
        do
        {
            slotNumber = rand() % MAX_PLAYING_CARDS;
        }while([occupiedSlots indexOfObject:[NSNumber numberWithInt:slotNumber]] != NSNotFound);
        
        [occupiedSlots addObject:[NSNumber numberWithInt:slotNumber]];
        int pos_x = [((NSNumber *)[xs objectAtIndex:slotNumber]) intValue];
        int pos_y = [((NSNumber *)[ys objectAtIndex:slotNumber]) intValue];
        
        //int pos_y = 120 + rand() % (height - CARD_IMAGE_HEIGHT - 120);
        //int pos_x = ((i+1) * position_x_offset) - (CARD_IMAGE_WIDTH/2);
        
        _cards[i].frame = CGRectMake(0, 0, 100, 100);
        
        [UIView beginAnimations:@"deal" context:nil]; 
        [UIView setAnimationDuration:0.5]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; 
        _cards[i].frame = CGRectMake(pos_x, pos_y, CARD_IMAGE_WIDTH, CARD_IMAGE_HEIGHT);
        [UIView commitAnimations];
        
        [_cards[i] coverWithAnimation:false];
    }
}



-(void)uncoverCard:(int)index isCorrect:(bool)isCorrect
{
    [_cards[index] uncoverAndWin:isCorrect];
    
    if (isCorrect)
        [_logic playCorrectCardSound];
    else
        [_logic playWrongCardSound];
}



-(void)looseGame
{
    // If there is lost state, then covered cards should not be uncover until next game
    int numberOfCards = [GameSettings numberOfCards];
    for(int i=0;i<numberOfCards;i++)
    {
        _cards[i].userInteractionEnabled = false;
    }
    
    [_logic registerResult:false];
    
    [self performSelector:@selector(showLooseDialog) withObject:nil afterDelay:1.5]; // wait for card to be uncover first
}



-(void)winGame
{
    // If there is win state, then covered cards should not be uncover until next game
    int numberOfCards = [GameSettings numberOfCards];
    for(int i=0;i<numberOfCards;i++)
    {
        _cards[i].userInteractionEnabled = false;
    }
    
    [_logic registerResult:true];
    
    [self performSelector:@selector(showWinDialog) withObject:nil afterDelay:1.5]; // wait for card to be uncover first
}



-(void)updateAttemptsLeft:(int)attemptsLeft
{
    [_attemptsLeftView changeNumber:attemptsLeft];
}






#pragma mark -
#pragma mark Playing Card View Delegate

-(void)cardTouched:(int)index
{   
    [_gameLogic cardTouched:index];
}






#pragma mark -
#pragma mark WinDialogControllerDelegate

-(void)publishAfterCloseDialog:(bool)publish
{
    [_winPopover dismissPopoverAnimated:YES];
    
    // fade in the background after return 
    [self fade:NO];
    
    if (publish) 
        [_logic publishWin];
    else  // start another game
        [self startNewGame];
}






#pragma mark -
#pragma mark LooseDialogControllerDelegate

-(void)playAgain
{
    [_loosePopover dismissPopoverAnimated:YES];
    
    // fade in the background after return 
    [self fade:NO];
    
    [self startNewGame];
}



-(void)backToMenu
{
    [_delegate backToMenu];
}





#pragma mark -
#pragma mark Private Methods

-(void)showWinDialog
{
    [_logic playWinnerSound];
    
    [_delegate showWinView];
/*    
    if(_winPopover != nil)  // can be still remain somewhere of double pop-up bug
    {
        [_winPopover dismissPopoverAnimated:YES];
        [_winPopover release];
        _winPopover = nil;
    }
    
    WinDialogController * winDialog = [[WinDialogController alloc] initWithNibName:@"WinDialog" andDelegate:self];
    _winPopover = [[UIPopoverController alloc] initWithContentViewController:winDialog];
    
    [_winPopover setPopoverContentSize:CGSizeMake(901, 1265) animated:YES];
    [_winPopover presentPopoverFromRect:CGRectMake(512, 0, 10, 10) inView:self.view permittedArrowDirections:0 animated:YES];
    _winPopover.delegate = winDialog;
    [winDialog release];
    
    // fade the background when showing win dialog
    [self fade:YES];
 */
}



-(void)showLooseDialog
{
    
    [_logic playLooserSound];
    
    if(_loosePopover != nil)  // can be still remain somewhere of double pop-up bug
    {
        [_loosePopover dismissPopoverAnimated:YES];
        [_loosePopover release];
        _loosePopover = nil;
    }
    
    LooseDialogController * dialog = [[LooseDialogController alloc] initWithNibName:@"LooseDialog" andDelegate:self];
    _loosePopover = [[UIPopoverController alloc] initWithContentViewController:dialog];
    
    [_loosePopover setPopoverContentSize:CGSizeMake(714, 860) animated:YES];
    [_loosePopover presentPopoverFromRect:CGRectMake(450, 10, 10, 10) inView:self.view permittedArrowDirections:0 animated:YES];
    _loosePopover.delegate = dialog;
    [dialog release];
    
    // fade the background when showing loose dialog
    [self fade:YES];
}



// fade the background when showing a dialog, or returning from it
-(void)fade:(bool)isFadeOut
{
    [UIView beginAnimations:@"fading" context:nil]; 
	[UIView setAnimationDuration:0.7]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; 
    
    self.view.alpha = isFadeOut? 0.3 : 1.0;
    
	[UIView commitAnimations]; 
}






#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
}




@end
