#import "GameLogic.h"

@implementation GameLogic

#pragma Mark Initialization

-(id)initWithDelegate:(id<GameLogicDelegate>)delegate
{
    self = [super init];
    
    if(self == nil)
        return nil;

    _delegate = delegate;
    
    return self;
}


#pragma Mark Public Methods

-(void)startGameWithCorrectCards:(int)numberOfCorrectCards 
                winProbability:(float)winProbability 
                 numberOfCards:(int)totalCards 
                andMaxAttempts:(int)maxAttempts
{
    numberOfCorrectCards = MIN(MIN(numberOfCorrectCards, totalCards), MAX_PLAYING_CARDS); // avoid more correct cards than cards in game
    
    if(((rand() % 101) > (winProbability * 100.0)) || (winProbability == 0.0))
        numberOfCorrectCards = 0; // can't win this game
    
    _totalCards = MIN(MAX_PLAYING_CARDS, totalCards);
    
    _correctCards = [[NSMutableArray alloc] initWithCapacity:numberOfCorrectCards];
    
    _attemptsLeft = maxAttempts;
    
    while (numberOfCorrectCards > 0) 
    {
        NSNumber * correctCard = [NSNumber numberWithInt:rand() % _totalCards];
        
        if([_correctCards indexOfObject:correctCard] == NSNotFound)
        {
            [_correctCards insertObject:correctCard atIndex:0]; // insert at beginning, it does not matter
            numberOfCorrectCards--;
        }
    }
    
    [_delegate dealCards];
    [_delegate updateAttemptsLeft:maxAttempts];
}



-(void)cardTouched:(int)index
{
    _attemptsLeft --;
    
    // uncover cards
    if([_correctCards indexOfObject:[NSNumber numberWithInt:index]] != NSNotFound)
    {
        [_delegate uncoverCard:index isCorrect:true];
        [_delegate winGame];
    }
    else
    {
        [_delegate uncoverCard:index isCorrect:false];
        // check if there is no attempts left
        if (_attemptsLeft == 0) 
            [_delegate looseGame];
    }
    
    if(_attemptsLeft >= 0)
        [_delegate updateAttemptsLeft:_attemptsLeft];
}

@end
