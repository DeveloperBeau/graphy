#import "CCBinaryOp.h"

@implementation CCBinaryOp

+ (instancetype)opWithSymbol:(NSString *)op left:(id<CCNode>)left right:(id<CCNode>)right {
    CCBinaryOp *node = [[CCBinaryOp alloc] init];
    node.op = op;
    node.left = left;
    node.right = right;
    return node;
}

- (NSString *)describe {
    return [NSString stringWithFormat:@"(%@ %@ %@)", [self.left describe], self.op, [self.right describe]];
}

@end
