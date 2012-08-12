#import <UIKit/UIKit.h>

#import "GameLogic.h"
#import "Logic.h"
#import "BoardGameViewController.h"
#import "MenuViewController.h"
#import "WelcomeViewController.h"
#import "WinDialogController.h"

@interface BNBFeicobolAppDelegate : NSObject <UIApplicationDelegate, LogicDelegate, MenuViewControllerDelegate, BoardGameViewControllerDelegate, WelcomeViewControllerDelegate, WinDialogControllerDelegate> 
{
    UIWindow *_window;
    BoardGameViewController * _boardViewController;
    MenuViewController * _menuViewController;
    WelcomeViewController * _welcomeViewController;
    WinDialogController * _winDialogController;
    
	
    GameLogic * _gameLogic;
    Logic * _logic;
}

@property (nonatomic, retain) IBOutlet UIWindow * window;

@end

