#import <Foundation/Foundation.h>
#import "CCReplContext.h"

@interface CCRepl : NSObject

- (instancetype)initWithContext:(CCReplContext *)context;

// Evaluates one line and logs the result to stdout; command lines
// starting with ":" are routed through CCCommandRouter instead.
- (void)runOnce:(NSString *)line;

@end
