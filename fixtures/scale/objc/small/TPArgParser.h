#import <Foundation/Foundation.h>
#import "TPOptions.h"

@interface TPArgParser : NSObject

// Reads --width, --align and --border flags from argv, falling
// back to TPOptions defaults for anything not passed.
+ (TPOptions *)parse:(NSArray<NSString *> *)args;

@end
