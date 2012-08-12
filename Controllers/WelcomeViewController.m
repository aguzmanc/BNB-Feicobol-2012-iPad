#import "WelcomeViewController.h"

@implementation WelcomeViewController


#pragma mark -
#pragma mark Initialization

-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<WelcomeViewControllerDelegate>)delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    
    if(self == nil) return nil;
    
    _delegate = delegate;
    
    return self;
}






#pragma mark -
#pragma mark Events

-(IBAction)playClick:(id)sender
{
    [_delegate playApp];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsLandscape(orientation);
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
