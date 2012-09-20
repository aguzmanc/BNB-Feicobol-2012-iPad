#import "WinDialogController.h"


@implementation WinDialogController

@synthesize logic = _logic;

#pragma mark Initialization

-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<WinDialogControllerDelegate>)delegate
{
    self = [self initWithNibName:nibNameOrNil bundle:nil];
    
    if(self == nil) return nil;
    
    _delegate = delegate;
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.modalInPopover = YES;
}


-(IBAction)okAtLike 
{
	[_logic atLike];
}



#pragma mark -
#pragma mark Events
-(void)updateBackground
{
    
}

-(void)generateLikeContent
{
	if (_likeButton != nil) {
		[_likeButton removeFromSuperview];
		[_likeButton release];
	}
	
	_likeButton = [[FBLikeButton alloc] initWithFrame:CGRectMake(0, 130, 320, 75) andUrl:TOP_APP_URL];
	[self.view addSubview:_likeButton];
}





#pragma mark -
#pragma mark Events

-(IBAction)publish:(id)sender
{
    [_logic publishWin];
}



-(IBAction)keepPlaying:(id)sender
{
    [_delegate returnToBoard];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	return UIInterfaceOrientationIsLandscape(orientation);
}





#pragma mark UIPopover Delegate

-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}




#pragma mark Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (void)viewDidUnload
{
    if (_likeButton != nil)	[_likeButton release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
