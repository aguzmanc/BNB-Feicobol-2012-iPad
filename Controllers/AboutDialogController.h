#import <UIKit/UIKit.h>

@protocol AboutDialogControllerDelegate;

@interface AboutDialogController : UIViewController <UIPopoverControllerDelegate>
{
    id<AboutDialogControllerDelegate> _delegate;
    
    int _taps;
}

// Initialization
-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<AboutDialogControllerDelegate>)delegate;
//Events
-(IBAction)closeClick:(id)sender;
-(IBAction)hiddenClick:(id)sender;

@end






@protocol AboutDialogControllerDelegate

-(void)closeAboutDialog;
-(void)hiddenFunction;

@end

