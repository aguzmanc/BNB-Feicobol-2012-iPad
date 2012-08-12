#import <Foundation/Foundation.h>

#define DEFAULT_NUMBER_OF_CARDS 5
#define DEFAULT_NUMBER_OF_CORRECT_CARDS 3
#define DEFAULT_WIN_PROBABILITY 1.0
#define DEFAULT_MAX_ATTEMPTS 3

@interface GameSettings : NSObject

+(int)numberOfCards;
+(int)numberOfCorrectCards;
+(float)winProbability;
+(int)maxAttempts;

@end
