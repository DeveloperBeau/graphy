#import "CCParser.h"
#import "CCParserInternal.h"
#import "CCLexer.h"
#import "CCAssignment.h"

@interface CCParser ()
@property (nonatomic, strong) NSMutableArray<CCToken *> *tokens;
@property (nonatomic, assign) NSUInteger index;
@end

@implementation CCParser

- (instancetype)initWithSource:(NSString *)source {
    if ((self = [super init])) {
        _tokens = [NSMutableArray array];
        CCLexer *lexer = [[CCLexer alloc] initWithSource:source];
        CCToken *token;
        do { token = [lexer nextToken]; [_tokens addObject:token]; } while (token.kind != CCTokenKindEnd);
    }
    return self;
}

- (CCToken *)current { return self.tokens[MIN(self.index, self.tokens.count - 1)]; }

- (CCToken *)advance {
    CCToken *token = [self current];
    self.index++; return token;
}

- (id<CCNode>)parseStatement {
    if (self.tokens.count > 2 && self.tokens[0].kind == CCTokenKindIdentifier &&
        self.tokens[1].kind == CCTokenKindEquals) {
        NSString *name = [self advance].text;
        [self advance];
        return [CCAssignment assignName:name value:[self parseExpression:1]];
    }
    return [self parseExpression:1];
}

@end
