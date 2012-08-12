#import "AboutDialogController.h"

@implementation AboutDialogController

#pragma mark -
#pragma mark Initialization

-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<AboutDialogControllerDelegate>)delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self == nil) return nil;
    
    _delegate = delegate;
    _taps = 0;
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.modalInPopover = YES;
}







#pragma mark -
#pragma mark Events

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsLandscape(orientation);
}



-(IBAction)closeClick:(id)sender;
{
    [_delegate closeAboutDialog];
}



-(IBAction)hiddenClick:(id)sender
{
    _taps++;
    if(_taps == 5)
    {
        _taps = 0;
        [_delegate hiddenFunction];
    }
}






#pragma mark -
#pragma mark UIPopoverControllerDelegate

-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}






#pragma mark -
#pragma mark Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
}



@end
