#import "CCStandardLibrary.h"
#import "CCTrigFunctions.h"
#import "CCLogFunctions.h"

@implementation CCStandardLibrary

+ (CCFunctionRegistry *)buildRegistry {
    CCFunctionRegistry *registry = [[CCFunctionRegistry alloc] init];
    [CCTrigFunctions installInto:registry];
    [CCLogFunctions installInto:registry];
    [registry define:@"sqrt" body:^double(NSArray<NSNumber *> *args) { return sqrt(args[0].doubleValue); }];
    [registry define:@"abs" body:^double(NSArray<NSNumber *> *args) { return fabs(args[0].doubleValue); }];
    return registry;
}

@end
