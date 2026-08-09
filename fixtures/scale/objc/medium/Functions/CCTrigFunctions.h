#import <Foundation/Foundation.h>
#import "CCFunctionRegistry.h"

@interface CCTrigFunctions : NSObject

// Registers sin/cos/tan; called once by CCStandardLibrary.buildRegistry.
// Angles are always radians; there is no CCSettings-driven degree mode.
+ (void)installInto:(CCFunctionRegistry *)registry;

@end
