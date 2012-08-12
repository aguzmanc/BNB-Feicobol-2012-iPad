#import "LooseDialogController.h"

@implementation LooseDialogController

#pragma mark Initialization 

-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<LooseDialogControllerDelegate>)delegate
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

-(IBAction)playAgain:(id)sender
{
    [_delegate playAgain];
}



-(IBAction)backToMenu:(id)sender
{
    [_delegate backToMenu];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}






#pragma mark -
#pragma mark UIPopover Delegate

-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}







#pragma mark -
#pragma mark Memory

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
