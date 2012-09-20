#import <UIKit/UIKit.h>

#import "Logic.h"
#import "WinDialogController.h"

@interface TOPFansAppDelegate : NSObject <UIApplicationDelegate, LogicDelegate, WinDialogControllerDelegate> 
{
    UIWindow *_window;
    
    WinDialogController * _winDialogController;
    
	Logic * _logic;
}

@property (nonatomic, retain) IBOutlet UIWindow * window;

@end

