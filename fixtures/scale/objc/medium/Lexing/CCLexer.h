#import <Foundation/Foundation.h>
#import "CCToken.h"

@interface CCLexer : NSObject

- (instancetype)initWithSource:(NSString *)source;

// Returns CCTokenKindEnd once the source is exhausted; safe to call
// again after that without advancing further.
- (CCToken *)nextToken;

@end
