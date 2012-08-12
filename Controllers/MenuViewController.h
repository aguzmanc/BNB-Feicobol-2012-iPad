#import <UIKit/UIKit.h>

#import "AboutDialogController.h"
#import "StatisticsDialogController.h"
#import "Logic.h"

@protocol MenuViewControllerDelegate;

@interface MenuViewController : UIViewController <AboutDialogControllerDelegate, StatisticsDialogControllerDelegate>
{
    id<MenuViewControllerDelegate> _delegate;
    
    IBOutlet UIButton * _option_food;
    IBOutlet UIButton * _option_home;
    IBOutlet UIButton * _option_health;
    IBOutlet UIButton * _option_other;
    IBOutlet UIButton * _option_clothes;
    
    UIPopoverController * _popoverAbout;
    UIPopoverController * _popoverSecret;
    IBOutlet UIButton * _btnAbout;
    IBOutlet UIButton * _btnSecret;
    
    Logic * _logic;
    
    int _secretTaps;
}

// Properties
@property (nonatomic, retain) Logic * logic;

// Initialization
-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<MenuViewControllerDelegate>)delegate;

// Events
-(IBAction)aboutClick:(id)sender;
-(IBAction)optionSelected:(id)sender;
-(IBAction)secretClick:(id)sender;

@end


@protocol MenuViewControllerDelegate

-(void)optionSelected:(NSString *)option;

@end
