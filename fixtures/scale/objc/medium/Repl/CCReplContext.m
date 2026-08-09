#import "CCReplContext.h"
#import "CCStandardLibrary.h"

@implementation CCReplContext

- (instancetype)initWithSettings:(CCSettings *)settings {
    if ((self = [super init])) {
        _environment = [[CCEnvironment alloc] init];
        _functions = [CCStandardLibrary buildRegistry];
        _history = [[CCHistoryLog alloc] init];
        _settings = settings;
    }
    return self;
}

@end
