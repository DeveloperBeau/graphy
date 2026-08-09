#import "CCFunctionCall.h"

@implementation CCFunctionCall

+ (instancetype)callWithName:(NSString *)name arguments:(NSArray<id<CCNode>> *)arguments {
    CCFunctionCall *node = [[CCFunctionCall alloc] init];
    node.name = name;
    node.arguments = arguments;
    return node;
}

- (NSString *)describe {
    return [NSString stringWithFormat:@"%@(...)", self.name];
}

@end
