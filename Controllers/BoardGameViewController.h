#import <UIKit/UIKit.h>

#import "Config.h"
#import "GameSettings.h"
#import "GameLogic.h"
#import "Logic.h"
#import "PlayingCardView.h"
#import "NumberView.h"
#import "LooseDialogController.h"
#import "BoardConfig.h"

@protocol BoardGameViewControllerDelegate;

@interface BoardGameViewController : UIViewController <LogicDelegate, 
                                                       GameLogicDelegate, PlayingCardViewDelegate,
                                                       LooseDialogControllerDelegate>
{
    id<BoardGameViewControllerDelegate> _delegate;
    
    GameLogic * _gameLogic;
    Logic * _logic;
    
    NumberView * _attemptsLeftView;
    PlayingCardView * _cards[MAX_PLAYING_CARDS];
    
    UIPopoverController * _winPopover;
    UIPopoverController * _loosePopover;
}

@property (nonatomic, retain) GameLogic * gameLogic;
@property (nonatomic, retain) Logic * logic;

// Initialization
-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<BoardGameViewControllerDelegate>)delegate;

// actions
-(IBAction) click;

// Public Methods
-(void)dealCards;
-(void)setBoardConfigPList:(NSString *)configFileName;
-(void)startNewGame;

// Private Methods
-(void)showWinDialog;
-(void)showLooseDialog;
-(void)fade:(bool)isFadeOut;

@end






@protocol BoardGameViewControllerDelegate

-(void)backToMenu;
-(void)showWinView;

@end