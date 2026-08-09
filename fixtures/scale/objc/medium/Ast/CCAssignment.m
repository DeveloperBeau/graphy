#import "CCAssignment.h"

@implementation CCAssignment

+ (instancetype)assignName:(NSString *)name value:(id<CCNode>)value {
    CCAssignment *node = [[CCAssignment alloc] init];
    node.name = name;
    node.value = value;
    return node;
}

- (NSString *)describe {
    return [NSString stringWithFormat:@"%@ = %@", self.name, [self.value describe]];
}

@end
