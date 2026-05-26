// feature: @implementation, method definition, call (local + message send)
#import "Service.h"

@implementation Service

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        _state = ServiceStateIdle;
    }
    return self;
}

- (void)run {
    NSString *greeting = [Helpers formatName:self.name];
    NSLog(@"%@", greeting);
    _state = ServiceStateRunning;
}

- (NSString *)greeting {
    return [NSString stringWithFormat:@"hello from %@", _name];
}

+ (id)shared {
    static Service *instance = nil;
    if (!instance) {
        instance = [[Service alloc] initWithName:@"default"];
    }
    return instance;
}

@end
