// feature: @implementation, method definition, calls
#import "Helpers.h"

@implementation Helpers

+ (NSString *)formatName:(NSString *)name {
    return [NSString stringWithFormat:@"hi, %@", name];
}

- (NSInteger)unrelatedHelper {
    return 7;
}

@end
