#import <UIKit/UIKit.h>
#import "FBLikeButton.h"
#import "Logic.h"


@protocol WinDialogControllerDelegate;

@interface WinDialogController : UIViewController <UIPopoverControllerDelegate>
{
    id<WinDialogControllerDelegate> _delegate;
    
    Logic * _logic;
    FBLikeButton * _likeButton;
    IBOutlet UIImageView * _background;
}

// Properties
@property (nonatomic, retain) Logic * logic;


//Initialization
-(id)initWithNibName:(NSString *)nibNameOrNil andDelegate:(id<WinDialogControllerDelegate>)delegate;
// Events
-(IBAction)publish:(id)sender;
-(IBAction)keepPlaying:(id)sender;
// Public Methods
-(void)updateBackground;

// Actions
-(IBAction)okAtLike;

@end






@protocol WinDialogControllerDelegate

-(void)returnToBoard;

@end