#import "CCToken.h"

@implementation CCToken

+ (instancetype)tokenWithKind:(CCTokenKind)kind text:(NSString *)text {
    CCToken *token = [[CCToken alloc] init];
    token.kind = kind;
    token.text = text;
    return token;
}

- (double)numberValue {
    return [self.text doubleValue];
}

@end
