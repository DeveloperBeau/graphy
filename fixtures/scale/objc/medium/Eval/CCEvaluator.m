#import "CCEvaluator.h"
#import "CCBinaryMath.h"
#import "CCNumberLiteral.h"
#import "CCVariableRef.h"
#import "CCBinaryOp.h"
#import "CCUnaryOp.h"
#import "CCAssignment.h"

@interface CCEvaluator ()
@property (nonatomic, strong) CCEnvironment *environment;
@property (nonatomic, strong) CCFunctionRegistry *functions;
@end

@implementation CCEvaluator

- (instancetype)initWithEnvironment:(CCEnvironment *)environment functions:(CCFunctionRegistry *)functions {
    if ((self = [super init])) { _environment = environment; _functions = functions; }
    return self;
}

- (double)eval:(id<CCNode>)node {
    if ([node isKindOfClass:[CCNumberLiteral class]]) return [(CCNumberLiteral *)node value];
    if ([node isKindOfClass:[CCVariableRef class]]) return [self.environment resolve:[(CCVariableRef *)node name]];
    if ([node isKindOfClass:[CCUnaryOp class]]) return -[self eval:[(CCUnaryOp *)node operand]];
    if ([node isKindOfClass:[CCBinaryOp class]]) {
        CCBinaryOp *binary = (CCBinaryOp *)node;
        return [CCBinaryMath apply:binary.op left:[self eval:binary.left] right:[self eval:binary.right]];
    }
    if ([node isKindOfClass:[CCAssignment class]]) {
        CCAssignment *assignment = (CCAssignment *)node;
        double value = [self eval:assignment.value];
        [self.environment assign:assignment.name value:value];
        return value;
    }
    return 0;
}

@end
