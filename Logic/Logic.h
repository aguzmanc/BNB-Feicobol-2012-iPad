#import <Foundation/Foundation.h>

#import "FacebookService.h"
#import "SoundsService.h"
#import "StatisticsDataService.h"

@protocol LogicDelegate;

@interface Logic : NSObject  <FacebookServiceDelegate>
{
    id<LogicDelegate> _delegate;
    
    FacebookService * _facebookService;
    SoundsService * _soundsService;
    StatisticsDataService * _statisticsDataService;
}

// Properties
@property (nonatomic, retain) id<LogicDelegate> delegate;

// Initialization
-(id)initWithDelegate:(id<LogicDelegate>)delegate;

// Public Methods
-(void)publishWin;
-(void)playWrongCardSound;
-(void)playCorrectCardSound;
-(void)playWinnerSound;
-(void)playLooserSound;
-(void)registerResult:(bool)isWin;
-(NSArray *)getUsageList;

//FacebookServiceDelegate
-(void)didLogin;
-(void)didPublish;

@end






@protocol LogicDelegate

-(void)showBoard;

@end
