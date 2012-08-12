#import "NumberView.h"

@implementation NumberView


#pragma Mark Initialization

- (id)initWithPosition:(CGPoint)position andNumber:(int)number
{
    CGRect frame = CGRectMake(position.x , position.y, DIGIT_IMAGE_WIDTH, DIGIT_IMAGE_HEIGHT);
    
    self = [super initWithFrame:frame];
    
    if(self == nil) return nil;
    
    number = number % 10; // last digit only
    
    _imageView = [[UIImageView alloc] initWithFrame:frame];    
    [self changeNumber:number];
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"digit_%d", number]];
    
    [self addSubview:_imageView];
       
    return self;
}




#pragma Mark Public Methods

-(void)changeNumber:(int)number
{
	[self performSelector:@selector(animNumberFadeOut) withObject:nil afterDelay:0];
	[self performSelector:@selector(changeImageNumber:) withObject:[NSNumber numberWithInt:number] afterDelay:0.2];
	[self performSelector:@selector(animNumberFadeIn) withObject:nil afterDelay:0.2];
}






#pragma Mark Private Methods

-(void)changeImageNumber:(NSNumber *)number
{
	_imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"digit_%d",[number intValue]]];
}



-(void)animNumberFadeOut
{
	_imageView.alpha = 1;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	
	_imageView.alpha = 0;
	
	[UIView commitAnimations];
}



-(void)animNumberFadeIn
{
	_imageView.alpha = 0;
	_imageView.transform = CGAffineTransformMakeScale(0.001, 0.001);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	
	_imageView.alpha = 1;
	_imageView.transform = CGAffineTransformMakeScale(1, 1);
	
	[UIView commitAnimations];
}






#pragma Mark Memory

- (void)dealloc 
{
    [super dealloc];
    
    [_imageView release];
	

}

@end
