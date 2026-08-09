#import "CCParser.h"
#import "CCToken.h"

// Shared declarations for the recursive-descent helpers split across
// CCParser.m, CCParserExpression.m and CCParserPrimary.m.
@interface CCParser (Internal)

- (CCToken *)current;
- (CCToken *)advance;
- (id<CCNode>)parseExpression:(NSInteger)minPrecedence;
- (id<CCNode>)parsePrimary;

@end
