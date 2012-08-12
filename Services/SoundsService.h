#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>


typedef enum
{
    kSoundWrongCard,
    kSoundCorrectCard,
    kSoundWinner,
    kSoundLooser
} SoundType;


@interface SoundsService : NSObject <AVAudioPlayerDelegate>

// Public Methods
-(void)playSound:(SoundType)soundtype;

@end
