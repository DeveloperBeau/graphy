#import <Foundation/Foundation.h>
#import "CCReplContext.h"

@interface CCCommandRouter : NSObject

// line is expected to start with ":"; unknown commands echo back
// an "unknown command" message rather than raising.
+ (NSString *)dispatch:(NSString *)line context:(CCReplContext *)context;

@end
