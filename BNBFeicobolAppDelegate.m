#import "BNBFeicobolAppDelegate.h"

@implementation BNBFeicobolAppDelegate

#pragma mark Properties

@synthesize window;

#pragma mark -
#pragma mark Initialization

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
    _welcomeViewController = [[WelcomeViewController alloc] initWithNibName:@"WelcomeView" andDelegate:self];
    _boardViewController = [[BoardGameViewController alloc] initWithNibName:@"BoardGameView" andDelegate:self];
    _menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuView" andDelegate:self];
    _winDialogController = [[WinDialogController alloc] initWithNibName:@"WinDialog" andDelegate:self];
        
    [self.window addSubview:_welcomeViewController.view];
    [self.window makeKeyAndVisible];
    
    _gameLogic = [[GameLogic alloc] initWithDelegate:_boardViewController];
    _logic = [[Logic alloc] initWithDelegate:self];
    
    
    _boardViewController.gameLogic = _gameLogic;
    _boardViewController.logic = _logic;
    _winDialogController.logic = _logic;
    _menuViewController.logic = _logic;
    
    
    
	return YES;
}






#pragma mark -
#pragma mark LogicDelegate

-(void)showBoard
{
    [_winDialogController.view removeFromSuperview];
    [self.window addSubview:_boardViewController.view];
    [_boardViewController startNewGame];
}






#pragma mark -
#pragma mark WelcomeViewControllerDelegate

-(void)playApp
{
    [_welcomeViewController.view removeFromSuperview];
    [self.window addSubview:_menuViewController.view];
    
    [_welcomeViewController release];  // we will not use this view anymore
}






#pragma mark -
#pragma mark WinViewControllerDelegate

-(void)returnToBoard
{
    [_winDialogController.view removeFromSuperview];
    [self.window addSubview:_boardViewController.view];
    [_boardViewController startNewGame];
}






#pragma mark -
#pragma mark MenuViewControllerDelegate

-(void)optionSelected:(NSString *)option
{
    if([option isEqualToString:@"food"])
        [_boardViewController setBoardConfigPList:@"config_food"]; // should change
    else if([option isEqualToString:@"home"])
        [_boardViewController setBoardConfigPList:@"config_home"]; // should change
    else if([option isEqualToString:@"health"])
        [_boardViewController setBoardConfigPList:@"config_health"]; // should change
    else if([option isEqualToString:@"clothes"])
        [_boardViewController setBoardConfigPList:@"config_clothes"]; // should change
    else if([option isEqualToString:@"other"])
        [_boardViewController setBoardConfigPList:@"config_other"]; // should change
    
    [_menuViewController.view removeFromSuperview];
    [self.window addSubview:_boardViewController.view];
}






#pragma mark -
#pragma mark BoardGameViewControllerDelegate
-(void)backToMenu
{
    // change current view
    [_boardViewController.view removeFromSuperview];
    [self.window addSubview:_menuViewController.view];
}



-(void)showWinView
{
    [_boardViewController.view removeFromSuperview];
    [self.window addSubview:_winDialogController.view];
    [_winDialogController updateBackground];
}






#pragma mark -
#pragma mark UIApplicationViewDelegate

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
    return false;
}



- (void)applicationWillResignActive:(UIApplication *)application 
{
}



- (void)applicationDidBecomeActive:(UIApplication *)application 
{
}



- (void)applicationWillTerminate:(UIApplication *)application 
{
}






#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
}



- (void)dealloc 
{
    [_boardViewController release];
    [window release];
    [super dealloc];
}


@end
