#import "CCParserInternal.h"
#import "CCNumberLiteral.h"
#import "CCVariableRef.h"
#import "CCFunctionCall.h"

@implementation CCParser (Primary)

- (id<CCNode>)parsePrimary {
    CCToken *token = [self advance];
    if (token.kind == CCTokenKindNumber) {
        return [CCNumberLiteral literalWithValue:[token numberValue]];
    }
    if (token.kind == CCTokenKindLeftParen) {
        id<CCNode> inner = [self parseExpression:1];
        [self advance];
        return inner;
    }
    if (token.kind == CCTokenKindIdentifier && [self current].kind == CCTokenKindLeftParen) {
        [self advance];
        NSMutableArray<id<CCNode>> *args = [NSMutableArray arrayWithObject:[self parseExpression:1]];
        while ([self current].kind == CCTokenKindComma) {
            [self advance];
            [args addObject:[self parseExpression:1]];
        }
        [self advance];
        return [CCFunctionCall callWithName:token.text arguments:args];
    }
    return [CCVariableRef refWithName:token.text];
}

@end
