#import "CCUnaryOp.h"

@implementation CCUnaryOp

+ (instancetype)opWithSymbol:(NSString *)op operand:(id<CCNode>)operand {
    CCUnaryOp *node = [[CCUnaryOp alloc] init];
    node.op = op;
    node.operand = operand;
    return node;
}

- (NSString *)describe {
    return [self.op stringByAppendingString:[self.operand describe]];
}

@end
