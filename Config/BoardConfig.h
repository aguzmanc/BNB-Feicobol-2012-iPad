#import <Foundation/Foundation.h>

@interface BoardConfig : NSObject
{
    NSArray * _backCards;
    NSString * _defaultBackCard;
    int _lastPickedCard;
    NSMutableArray * _pickedCards;
    
    NSString * _correctCard;
    NSString * _wrongCard;
    bool _useTransparencyForWrongCard;
    
    NSString * _winBackground;
}

@property (readonly) NSString * correctCard;
@property (readonly) NSString * wrongCard;
@property (readonly) bool useTransparencyForWrongCard;

// Singleton Instance
+(BoardConfig *)sharedInstance;

// Public Methods
-(void)loadConfig:(NSString *)stringFileName;
-(NSString *)nextBackCard; 
-(void)restartDealingCards;
-(NSString *)winBackground;

@end
