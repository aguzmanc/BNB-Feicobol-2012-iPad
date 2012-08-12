#import <UIKit/UIKit.h>

#import "Config.h"
#import "BoardConfig.h"


#define CARD_IMAGE_WIDTH 140
#define CARD_IMAGE_HEIGHT 160

@protocol PlayingCardViewDelegate;

@interface PlayingCardView : UIView 
{
	int _index;
    UIImageView * _frontSide;
	UIImageView * _backSide;
    
	id<PlayingCardViewDelegate> _delegate;
}

// Initialization
-(id)initWithPosition:(CGPoint)position index:(int)index andDelegate:(id<PlayingCardViewDelegate>)delegate;
// Public Methods
-(void)uncoverAndWin:(bool)hasWon;
-(void)coverWithAnimation:(bool)animate;

@end






@protocol PlayingCardViewDelegate

-(void)cardTouched:(int)index;

@end

