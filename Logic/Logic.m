#import "Logic.h"

@implementation Logic

@synthesize delegate = _delegate;

#pragma mark Initialization

-(id)initWithDelegate:(id<LogicDelegate>)delegate
{
    self = [super init];
    
    if(self==nil) return nil;
    
    _delegate = delegate;
    _facebookService = [[FacebookService alloc] initWithDelegate:self];
    
    _soundsService = [[SoundsService alloc] init];
    
    _statisticsDataService = [[StatisticsDataService alloc] init];
    [_statisticsDataService openDatabase];
    [_statisticsDataService createUsageTable];
    
    return self;
}






#pragma mark Public Methods

-(void)publishWin
{
    if (_facebookService.isLogged)  // maybe it was not logged out on time
    {
        [_facebookService logout];
        [self performSelector:@selector(publishWin) withObject:nil afterDelay:1.0]; //do another try after a second later.
    }
    
    [_facebookService login];
}

-(void)atLike
{
    [_facebookService checkIfUserIsFan];
}

-(void)playWrongCardSound
{
    [_soundsService playSound:kSoundWrongCard];
}



-(void)playCorrectCardSound
{
    [_soundsService playSound:kSoundCorrectCard];
}



-(void)playWinnerSound
{
    [_soundsService playSound:kSoundWinner];
}



-(void)playLooserSound
{
    [_soundsService playSound:kSoundLooser];
}



-(void)registerResult:(bool)isWin
{
    NSArray * results = [_statisticsDataService getUsageTable];
    
    // update wins or loses for current date
    bool exists = NO;
    
    NSDateComponents * currentDateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                                               fromDate:[NSDate date]];    
    for (Usage * usage in results) 
    {
        NSDateComponents * usageComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                                             fromDate:usage.date];
        
        if ([usageComponents year] == [currentDateComponents year] &&
            [usageComponents month] == [currentDateComponents month] &&
            [usageComponents day] == [currentDateComponents day]) 
        {
            exists = YES;
            
            if(isWin) usage.wins++;
            else usage.loses ++;
            
            if([_statisticsDataService insertUsage:usage]) // insert or update
                NSLog(@"Insert Successful");
            else
                NSLog(@"Insert Failure!!");
            
            break;
        }
    }
    
    if(exists == NO) // then create a new row
    {
        int wins = 0, loses = 0;
        if (isWin) wins++;
        else loses++;
        
        Usage * usage = [[Usage alloc] initWithDate:[NSDate date] wins:wins andLoses:loses];
        
        if([_statisticsDataService insertUsage:usage]) // insert or update
            NSLog(@"Insert Successful");
        else
            NSLog(@"Insert Failure!!");
    }
}



-(NSArray *)getUsageList;
{
    return [_statisticsDataService getUsageTable];
}






#pragma mark FacebookServiceDelegate

-(void)didLogin
{
    NSLog(@"LOGGEDDD!!! (in logic)");
    
    // just when log in, publish the message
    [_facebookService publish];
}



-(void)didPublish
{
    // logout when published
    [_facebookService logout];
    [_delegate showBoard];
}

@end
