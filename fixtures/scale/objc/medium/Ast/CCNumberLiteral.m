#import "CCNumberLiteral.h"

@implementation CCNumberLiteral

+ (instancetype)literalWithValue:(double)value {
    CCNumberLiteral *node = [[CCNumberLiteral alloc] init];
    node.value = value;
    return node;
}

- (NSString *)describe {
    return [NSString stringWithFormat:@"%g", self.value];
}

@end
