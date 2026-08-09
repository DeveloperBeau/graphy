#import "CCParserInternal.h"
#import "CCBinaryOp.h"
#import "CCPrecedence.h"

@implementation CCParser (Expression)

- (id<CCNode>)parseExpression:(NSInteger)minPrecedence {
    id<CCNode> left = [self parsePrimary];
    while ([self current].kind == CCTokenKindOperator &&
           [CCPrecedence of:[self current].text] >= minPrecedence) {
        NSString *op = [self advance].text;
        NSInteger next = [CCPrecedence of:op] + 1;
        left = [CCBinaryOp opWithSymbol:op left:left right:[self parseExpression:next]];
    }
    return left;
}

@end
