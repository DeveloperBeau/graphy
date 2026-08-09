#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCParser : NSObject

- (instancetype)initWithSource:(NSString *)source;

// Parses one line: either an assignment ("x = ...") or a bare expression.
- (id<CCNode>)parseStatement;

@end
