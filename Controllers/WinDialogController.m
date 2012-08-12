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






#pragma mark -
#pragma mark Events
-(void)updateBackground
{
    _background.image = [UIImage imageNamed:[[BoardConfig sharedInstance] winBackground]];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
