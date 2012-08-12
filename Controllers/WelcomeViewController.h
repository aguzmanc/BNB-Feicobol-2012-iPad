#import <UIKit/UIKit.h>

@protocol WelcomeViewControllerDelegate;

@interface WelcomeViewController : UIViewController
{
    id<WelcomeViewControllerDelegate> _delegate;
}

// Initialization
-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<WelcomeViewControllerDelegate>)delegate;
// Events
-(IBAction)playClick:(id)sender;


@end


@protocol WelcomeViewControllerDelegate

-(void)playApp;

@end