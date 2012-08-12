#import "MenuViewController.h"

@implementation MenuViewController

@synthesize logic = _logic;

#pragma mark -
#pragma mark Initialization

-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<MenuViewControllerDelegate>)delegate;
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self == nil) return nil;
    
    _delegate = delegate;
    
    _secretTaps = 0;
        
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}






#pragma mark -
#pragma mark Events

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	return UIInterfaceOrientationIsLandscape(orientation);
}



-(IBAction)optionSelected:(id)sender
{
    if(sender == _option_clothes)
        [_delegate optionSelected:@"clothes"];
    else if(sender == _option_food)
        [_delegate optionSelected:@"food"];
    else if(sender == _option_health)
        [_delegate optionSelected:@"health"];
    else if(sender == _option_home)
        [_delegate optionSelected:@"home"];
    else if(sender == _option_other)
        [_delegate optionSelected:@"other"];
}



-(IBAction)aboutClick:(id)sender
{
    AboutDialogController * dialog = [[AboutDialogController alloc] initWithNibName:@"AboutDialog" andDelegate:self];
    _popoverAbout = [[UIPopoverController alloc] initWithContentViewController:dialog];
    
    [_popoverAbout setPopoverContentSize:CGSizeMake(628, 521) animated:NO];
    _popoverAbout.delegate = dialog;
    [_popoverAbout presentPopoverFromRect:_btnAbout.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:NO];
    [dialog release];
    
    [self view].alpha = 0.3;
}



-(IBAction)secretClick:(id)sender
{
    _secretTaps ++;
    
    if(_secretTaps == 5)
    {
        _secretTaps = 0;
        
        StatisticsDialogController * dialog = [[StatisticsDialogController alloc] initWithNibName:@"StatisticsDialog" logic:_logic andDelegate:self];
        _popoverSecret = [[UIPopoverController alloc] initWithContentViewController:dialog];
        _popoverSecret.delegate = dialog;
        [_popoverSecret setPopoverContentSize:CGSizeMake(528, 521) animated:NO];
        [_popoverSecret presentPopoverFromRect:_btnSecret.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:NO];
        [dialog release];
        
        [self view].alpha = 0.3;
    }
}





#pragma mark -
#pragma mark AboutDialogControllerDelegate

-(void)closeAboutDialog
{
    [_popoverAbout dismissPopoverAnimated:NO];
    [_popoverAbout release];
    _popoverAbout = nil;
    
    [self view].alpha = 1.0;
}


-(void)hiddenFunction
{
    [_popoverAbout dismissPopoverAnimated:NO];
    [_popoverAbout release];
    _popoverAbout = nil;
    
    StatisticsDialogController * dialog = [[StatisticsDialogController alloc] initWithNibName:@"StatisticsDialog" logic:_logic andDelegate:self];
    _popoverSecret = [[UIPopoverController alloc] initWithContentViewController:dialog];
    _popoverSecret.delegate = dialog;
    [_popoverSecret setPopoverContentSize:CGSizeMake(528, 521) animated:NO];
    [_popoverSecret presentPopoverFromRect:_btnSecret.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:NO];
    [dialog release];
}






#pragma mark -
#pragma mark StatisticsDialogControllerDelegate

-(void)closeStatistics
{
    [_popoverSecret dismissPopoverAnimated:NO];
    [_popoverSecret release];
    _popoverSecret = nil;
    
    [self view].alpha = 1.0;
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
