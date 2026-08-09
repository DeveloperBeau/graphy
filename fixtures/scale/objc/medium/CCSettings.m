#import "CCSettings.h"

@implementation CCSettings

+ (instancetype)interactive {
    CCSettings *settings = [[CCSettings alloc] init];
    settings.precision = 6;
    settings.running = YES;
    return settings;
}

@end
