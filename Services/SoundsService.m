

#import "SoundsService.h"

@implementation SoundsService

#pragma mark -
#pragma mark Public Methods

-(void)playSound:(SoundType)soundtype
{
    NSString * soundFileName;
    
    switch (soundtype) {
        case kSoundWrongCard:
            soundFileName = [NSString stringWithString:@"wrong_card"];
            break;
        case kSoundCorrectCard:
            soundFileName = [NSString stringWithString:@"correct_card"];
            break;
        case kSoundLooser:
            soundFileName = [NSString stringWithString:@"looser"];
            break;
        case kSoundWinner:
            soundFileName = [NSString stringWithString:@"winner"];
            break;
    }

    
    NSError * error;
    NSString * path = [[NSBundle mainBundle] pathForResource:soundFileName ofType:@"caf"];    
    NSURL * url = [NSURL fileURLWithPath:path isDirectory:NO];
    AVAudioPlayer * pl = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [pl setDelegate:self];
    
    NSLog(@"Playing :%@.caf", soundFileName);
    [pl prepareToPlay];
    [pl play];
}






#pragma mark -
#pragma mark AVAudioPlayerDelegate

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(flag)
    {
        [player release];
        NSLog(@"Finished playing sound");
    }
    else
        NSLog(@"FAILED to finish playing sound");

}





@end
