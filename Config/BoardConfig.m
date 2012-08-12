#import "BoardConfig.h"

@implementation BoardConfig

@synthesize correctCard = _correctCard;
@synthesize wrongCard = _wrongCard;
@synthesize useTransparencyForWrongCard = _useTransparencyForWrongCard;

#pragma mark Singleton Instance

+(BoardConfig *)sharedInstance;
{
    static BoardConfig * sharedInstance;
    
    if(sharedInstance == nil)
    {
        sharedInstance = [[BoardConfig alloc] init];
    }
    
    return sharedInstance;
}






#pragma mark -
#pragma mark Public Methods

-(void)loadConfig:(NSString *)stringFileName
{
    NSString * path = [[NSBundle mainBundle] pathForResource:stringFileName ofType:@"plist"];
	NSDictionary * config = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    _backCards = [config objectForKey:@"back_cards"];
    _defaultBackCard = [config objectForKey:@"default_back_card"];
    _pickedCards = [[NSMutableArray alloc] init];
    [self restartDealingCards];
    
    _correctCard = [config objectForKey:@"correct_card"];
    _wrongCard = [config objectForKey:@"wrong_card"];
    
    if([config objectForKey:@"use_transparency_for_wrong_card"] == nil)
        _useTransparencyForWrongCard = true; // default value
    else
        _useTransparencyForWrongCard = [[config objectForKey:@"use_transparency_for_wrong_card"] boolValue];
    
    _winBackground = [config objectForKey:@"win_background"];
}



// return a unique card each time (it does not return the same card twice)
-(NSString *)nextBackCard
{
    if((_lastPickedCard + 1) >= [_backCards count])
        return _defaultBackCard; // all cards were already picked
    
    _lastPickedCard ++;
    
    // pick unique card
    int pick = -1;
    
    do 
    {
        pick = rand() % [_backCards count];
    } while ([_pickedCards indexOfObject:[NSNumber numberWithInt:pick]] != NSNotFound); 
    
    [_pickedCards addObject:[NSNumber numberWithInt:pick]];
    
    
    return [_backCards objectAtIndex:pick];
}



-(void)restartDealingCards
{
    _lastPickedCard = -1;
    if(_pickedCards != nil)
    {
        [_pickedCards removeAllObjects];
    }
}



-(NSString *)winBackground
{
    return _winBackground;
}

@end
