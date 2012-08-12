#import <UIKit/UIKit.h>


#define DIGIT_IMAGE_WIDTH 90
#define DIGIT_IMAGE_HEIGHT 100

@interface NumberView : UIView 
{
	UIImageView * _imageView;
}

// Initialization
- (id)initWithPosition:(CGPoint)position andNumber:(int)number;

// Public Methods
-(void)changeNumber:(int)number;

// Private Methods
-(void)changeImageNumber:(NSNumber *)number;
-(void)animNumberFadeOut;
-(void)animNumberFadeIn;

@end
