#import <UIKit/UIKit.h>

@protocol LooseDialogControllerDelegate;

@interface LooseDialogController : UIViewController <UIPopoverControllerDelegate>

{
    id<LooseDialogControllerDelegate> _delegate;
}

//Initialization
-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<LooseDialogControllerDelegate>)delegate;

// Events
-(IBAction)playAgain:(id)sender;
-(IBAction)backToMenu:(id)sender;

@end


@protocol LooseDialogControllerDelegate

-(void)playAgain;
-(void)backToMenu;

@end

