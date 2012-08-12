#import <Foundation/Foundation.h>

#import "Facebook.h"

#import "Config.h"

@protocol FacebookServiceDelegate;

@interface FacebookService : NSObject  <FBDialogDelegate,FBSessionDelegate, FBRequestDelegate>
{
    Facebook * _facebook;
    bool _isLogged;
    NSString * _userName;
    
    id<FacebookServiceDelegate> _delegate;
}

@property (readonly)bool isLogged;
@property (readonly)NSString * userName;


// Initialization
-(id)initWithDelegate:(id<FacebookServiceDelegate>)delegate;
// Public Methods
-(void)login;
-(void)logout;
-(void)publish;

@end





@protocol FacebookServiceDelegate

-(void)didLogin;
-(void)didPublish;

@end
