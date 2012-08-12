#import "PlayingCardView.h"

@implementation PlayingCardView

#pragma Mark Initialization

-(id)initWithPosition:(CGPoint)position 
                index:(int)index 
          andDelegate:(id<PlayingCardViewDelegate>)delegate
{
    CGRect frame = CGRectMake(position.x, position.y, CARD_IMAGE_WIDTH, CARD_IMAGE_HEIGHT);
    
	[super initWithFrame:frame];
	
	_delegate = delegate;
	_index = index;
    
    _backSide = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CARD_IMAGE_WIDTH, CARD_IMAGE_HEIGHT)];
    _frontSide = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CARD_IMAGE_WIDTH, CARD_IMAGE_HEIGHT)];    
    
    _backSide.image = [UIImage imageNamed:[[BoardConfig sharedInstance] nextBackCard]]; // all cards are by default showing back side
    _backSide.hidden = NO;
    
    _frontSide.hidden = YES;
	
	[self addSubview:_backSide];
	[self addSubview:_frontSide];
    
    self.userInteractionEnabled = YES;  // a card is always usable at the beginning
	
	return self;
}






#pragma Mark Public Methods

-(void)uncoverAndWin:(bool)hasWon
{
    self.userInteractionEnabled = NO; // avoid use of this card until next game
    
    if ([[BoardConfig sharedInstance] useTransparencyForWrongCard])  // using the same image than back card, but with transparency
    {
        if(hasWon)
        {
            _frontSide.image = [UIImage imageNamed:[[BoardConfig sharedInstance] correctCard]];
            _frontSide.alpha = 1.0;
        }
        else // loose
        {
            _frontSide.image = _backSide.image;
            _frontSide.alpha = 0.3;
        }
    }
    else // use customized image
    {
        NSString * imageName = hasWon ? [[BoardConfig sharedInstance] correctCard]: [[BoardConfig sharedInstance] wrongCard];
        _frontSide.image = [UIImage imageNamed:imageName];
    }
    
	// FLIP THE CARD
    // hidding the back side
	[UIView beginAnimations:@"flipping view" context:nil]; 
	[UIView setAnimationDuration:0.9]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn]; 
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft 
						   forView:_backSide cache:YES]; 
    
	[_backSide setHidden:YES]; 
	[UIView commitAnimations];
    
    // showing the front side
	[UIView beginAnimations:@"flipping view" context:nil]; 
	[UIView setAnimationDuration:1.5]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; 
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft 
						   forView:_frontSide cache:YES]; 
	[_frontSide setHidden:NO];
	[UIView commitAnimations];
}



-(void)coverWithAnimation:(bool)animate
{
    self.userInteractionEnabled = YES; // when covered, user can use this card
    
    // FLIP THE CARD
    // showing the back side
    if (animate) {
        [UIView beginAnimations:@"flipping view" context:nil]; 
        [UIView setAnimationDuration:0.9]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn]; 
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft 
                               forView:_backSide cache:YES]; 
    }   
    
	[_backSide setHidden:NO]; 
    
    if(animate)
    {
        [UIView commitAnimations];
    
        // hidden the front side
        [UIView beginAnimations:@"flipping view" context:nil]; 
        [UIView setAnimationDuration:1.5]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; 
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft 
                               forView:_frontSide cache:YES]; 
    }
    
	[_frontSide setHidden:YES];
    
    if(animate)
        [UIView commitAnimations];
}






#pragma Mark Touch Delegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_delegate cardTouched:_index];
}






#pragma Mark Memory
- (void)dealloc 
{
    [_frontSide release];
    [_backSide release];
    
    [super dealloc];
}


@end
