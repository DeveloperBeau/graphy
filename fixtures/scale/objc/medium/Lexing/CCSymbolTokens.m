#import "CCSymbolTokens.h"

@implementation CCSymbolTokens

+ (CCToken *)tokenFor:(unichar)ch {
    NSString *single = [NSString stringWithCharacters:&ch length:1];
    if (ch == '(') return [CCToken tokenWithKind:CCTokenKindLeftParen text:single];
    if (ch == ')') return [CCToken tokenWithKind:CCTokenKindRightParen text:single];
    if (ch == ',') return [CCToken tokenWithKind:CCTokenKindComma text:single];
    if (ch == '=') return [CCToken tokenWithKind:CCTokenKindEquals text:single];
    return [CCToken tokenWithKind:CCTokenKindOperator text:single];
}

@end
