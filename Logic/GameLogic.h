#import <Foundation/Foundation.h>

#import "Config.h"

@protocol GameLogicDelegate;

@interface GameLogic : NSObject
{
    id<GameLogicDelegate> _delegate;
    
    int _totalCards;
    int _attemptsLeft;
    NSMutableArray * _correctCards;
}

// Initialization
-(id)initWithDelegate:(id<GameLogicDelegate>)delegate;

// Public Methods
// difficulty should be a value between 0 and 1
-(void)startGameWithCorrectCards:(int)numberOfCorrectCards
                winProbability:(float)winProbability 
                 numberOfCards:(int)totalCards 
                andMaxAttempts:(int)maxAttempts;

// Determine if is the correct card
-(void)cardTouched:(int)index;

@end






@protocol GameLogicDelegate

-(void)dealCards;
-(void)uncoverCard:(int)index isCorrect:(bool)isCorrect;
-(void)looseGame;
-(void)winGame;
-(void)updateAttemptsLeft:(int)attemptsLeft;

@end
