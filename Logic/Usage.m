#import "Usage.h"

@implementation Usage

@synthesize date = _date;
@synthesize wins = _wins;
@synthesize loses = _loses;

#pragma mark -
#pragma mark Initialization

-(id)initWithDate:(NSDate *)date wins:(int)wins andLoses:(int)loses
{
    self = [super init];
    
    if(self == nil) return nil;
    
    _date = [date retain];
    _wins = wins;
    _loses = loses;
    
    return self;
}


@end
