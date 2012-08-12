#import "GameSettings.h"

@implementation GameSettings

+(int)numberOfCards
{
    NSNumber * numberOfCards = [[NSUserDefaults standardUserDefaults] objectForKey:@"number_of_cards"];
    
    if(numberOfCards == nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:DEFAULT_NUMBER_OF_CARDS] forKey:@"number_of_cards"];
        numberOfCards = [[NSUserDefaults standardUserDefaults] objectForKey:@"number_of_cards"];
    }
    
    return [numberOfCards intValue];
}



+(int)numberOfCorrectCards;
{
    NSNumber * numberOfCorrectCards = [[NSUserDefaults standardUserDefaults] objectForKey:@"number_of_correct_cards"];
    
    if(numberOfCorrectCards == nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:DEFAULT_NUMBER_OF_CORRECT_CARDS] forKey:@"number_of_correct_cards"];
        numberOfCorrectCards = [[NSUserDefaults standardUserDefaults] objectForKey:@"number_of_correct_cards"];
    }
    
    return [numberOfCorrectCards intValue];
}



+(float)winProbability
{
    NSNumber * winProbability = [[NSUserDefaults standardUserDefaults] objectForKey:@"win_probability"];
    
    if(winProbability == nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:DEFAULT_WIN_PROBABILITY] forKey:@"win_probability"];
        winProbability = [[NSUserDefaults standardUserDefaults] objectForKey:@"win_probability"];
    }
    
    return [winProbability floatValue];
}



+(int)maxAttempts
{
    NSNumber * maxAttempts = [[NSUserDefaults standardUserDefaults] objectForKey:@"max_attempts"];
    
    if(maxAttempts == nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:DEFAULT_MAX_ATTEMPTS] forKey:@"max_attempts"];
        maxAttempts = [[NSUserDefaults standardUserDefaults] objectForKey:@"max_attempts"];
    }
    
    return [maxAttempts intValue];

}


@end
