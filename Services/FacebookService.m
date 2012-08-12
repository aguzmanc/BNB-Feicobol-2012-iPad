#import "FacebookService.h"

@implementation FacebookService

@synthesize isLogged = _isLogged;
@synthesize userName = _userName;

#pragma mark Initialization

-(id)initWithDelegate:(id<FacebookServiceDelegate>)delegate
{
    self = [super init];
    
    if(self == nil) return nil;
    
    _delegate = delegate;
    
    _facebook = [[Facebook alloc] initWithAppId:FACEBOOK_APP_ID andDelegate:self];
    _isLogged = false;

    return self;

}






#pragma mark Public Methods

-(void)login
{
    [_facebook authorize:[NSArray arrayWithObjects:@"publish_stream",nil]];
}



-(void)logout
{
    [_facebook logout:self];
}



-(void)publish
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   //kAppId, @"app_id",
								   @"https://www.facebook.com/bancajovenBNB", @"link",
								   @"http://www.nerdsavenue.com/card_banca_joven.png", @"picture",
								   @"BANCA JOVEN DEL BNB", @"name",
								   @"https://www.facebook.com/bancajovenBNB", @"caption",
								   [NSString stringWithFormat:@"%@ ha participado del \"Juega y Gana con la Banca Joven\" en la Feicobol 2012. Ahora, está disfrutando de fabulosos regalos de nuestros comercios afiliados. Tú también puedes participar, ven y visítanos en nuestro Stand.", _userName], @"description",
								   @"",  @"message",
								   nil];
	
	[_facebook dialog:@"feed" andParams:params andDelegate:self];
}





#pragma mark -
#pragma mark FBSessionDelegate

- (void)fbDidLogin 
{
	NSLog(@"Facebook logged in");
    _isLogged = true;
    
    [_facebook requestWithGraphPath:@"me" andDelegate:self];
}



-(void)fbDidNotLogin:(BOOL)cancelled 
{
	NSLog(@"Facebook login cancelled");
    _isLogged = false;
}



- (void)fbDidLogout 
{
	NSLog(@"Facebook logged out");
    _isLogged = false;
}






#pragma mark -
#pragma mark FBDialogDelegate

-(void)dialogDidComplete:(FBDialog *)dialog {
    NSLog(@"publish successfully");
    
    [_delegate didPublish];
}



-(void)dialogDidNotComplete:(FBDialog *)dialog
{
    NSLog(@"publish cancelled");
    
    [_facebook logout:self];
}






#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didLoad:(id)result
{
    _userName = [[NSString stringWithString:[result objectForKey:@"name"]] retain];
    
    [_delegate didLogin];
}



@end
