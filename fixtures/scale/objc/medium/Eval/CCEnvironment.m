#import "CCEnvironment.h"

@interface CCEnvironment ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *variables;
@end

@implementation CCEnvironment

- (instancetype)init {
    if ((self = [super init])) {
        _variables = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)assign:(NSString *)name value:(double)value {
    self.variables[name] = @(value);
}

- (double)resolve:(NSString *)name {
    return [self.variables[name] doubleValue];
}

- (NSArray<NSString *> *)names {
    return [self.variables.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

@end
