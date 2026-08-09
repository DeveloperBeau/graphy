#import <Foundation/Foundation.h>
#import "CCFunctionRegistry.h"

@interface CCStandardLibrary : NSObject

// Assembles a registry preloaded with every builtin function group.
// Called once per REPL session from CCReplContext's initializer.
+ (CCFunctionRegistry *)buildRegistry;

@end
