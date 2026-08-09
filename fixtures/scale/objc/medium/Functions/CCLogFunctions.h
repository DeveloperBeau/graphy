#import <Foundation/Foundation.h>
#import "CCFunctionRegistry.h"

@interface CCLogFunctions : NSObject

// Registers ln/log10/exp; called once by CCStandardLibrary.buildRegistry.
// ln(0) and log10(0) return -inf rather than raising, matching libm.
+ (void)installInto:(CCFunctionRegistry *)registry;

@end
