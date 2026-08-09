#import "CCVariableRef.h"

@implementation CCVariableRef

+ (instancetype)refWithName:(NSString *)name {
    CCVariableRef *node = [[CCVariableRef alloc] init];
    node.name = name;
    return node;
}

- (NSString *)describe {
    return self.name;
}

@end
