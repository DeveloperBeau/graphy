#import "CCMemoryStore.h"

@interface CCMemoryStore ()
@property (nonatomic, assign) double slot;
@end

@implementation CCMemoryStore

- (void)store:(double)value {
    self.slot = value;
}

- (double)recall {
    return self.slot;
}

- (void)clear {
    self.slot = 0;
}

@end
