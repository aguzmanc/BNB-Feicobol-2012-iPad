#import <Foundation/Foundation.h>

@interface Usage : NSObject
{
    NSDate * _date;
    int _wins;
    int _loses;
}

// Properties
@property (nonatomic, retain) NSDate * date;
@property (nonatomic) int wins;
@property (nonatomic) int loses;

// Initialization
-(id)initWithDate:(NSDate *)date wins:(int)wins andLoses:(int)loses;

@end
