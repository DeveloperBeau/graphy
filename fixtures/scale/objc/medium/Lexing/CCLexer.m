#import "CCLexer.h"
#import "CCSymbolTokens.h"

@interface CCLexer ()
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) NSUInteger position;
@end

@implementation CCLexer

- (instancetype)initWithSource:(NSString *)source {
    if ((self = [super init])) { _source = source; _position = 0; }
    return self;
}

- (unichar)peek {
    return self.position < self.source.length ? [self.source characterAtIndex:self.position] : 0;
}

- (CCToken *)nextToken {
    while ([[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self peek]]) { self.position++; }
    if (self.position >= self.source.length) { return [CCToken tokenWithKind:CCTokenKindEnd text:@""]; }
    unichar ch = [self peek];
    if (isdigit(ch)) { return [self readWhile:CCTokenKindNumber test:^BOOL(unichar c) { return isdigit(c) || c == '.'; }]; }
    if (isalpha(ch)) { return [self readWhile:CCTokenKindIdentifier test:^BOOL(unichar c) { return isalpha(c); }]; }
    self.position++;
    return [CCSymbolTokens tokenFor:ch];
}

- (CCToken *)readWhile:(CCTokenKind)kind test:(BOOL (^)(unichar))test {
    NSUInteger start = self.position;
    while (test([self peek])) { self.position++; }
    NSString *text = [self.source substringWithRange:NSMakeRange(start, self.position - start)];
    return [CCToken tokenWithKind:kind text:text];
}

@end
