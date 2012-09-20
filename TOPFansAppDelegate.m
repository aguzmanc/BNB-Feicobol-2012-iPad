#import "TOPFansAppDelegate.h"

@implementation TOPFansAppDelegate

#pragma mark Properties

@synthesize window;

#pragma mark -
#pragma mark Initialization

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
    _winDialogController = [[WinDialogController alloc] initWithNibName:@"WinDialog" andDelegate:self];
        
    [self.window addSubview:_winDialogController.view];
    [self.window makeKeyAndVisible];
    
    _logic = [[Logic alloc] initWithDelegate:self];
    
    
    _winDialogController.logic = _logic;
        
    
	return YES;
}






#pragma mark -
#pragma mark LogicDelegate

-(void)showBoard
{
    [_winDialogController.view removeFromSuperview];
}


#pragma mark -
#pragma mark WinViewControllerDelegate

-(void)returnToBoard
{
    [_winDialogController.view removeFromSuperview];
//   [self.window addSubview:_boardViewController.view];
//    [_boardViewController startNewGame];
}


-(void)showWinView
{
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
    [_winDialogController release];
    [window release];
    [super dealloc];
}


@end
