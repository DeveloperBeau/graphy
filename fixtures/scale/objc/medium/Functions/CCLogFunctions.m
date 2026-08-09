#import "CCLogFunctions.h"

@implementation CCLogFunctions

+ (void)installInto:(CCFunctionRegistry *)registry {
    [registry define:@"ln" body:^double(NSArray<NSNumber *> *args) { return log(args[0].doubleValue); }];
    [registry define:@"log10" body:^double(NSArray<NSNumber *> *args) { return log10(args[0].doubleValue); }];
    [registry define:@"exp" body:^double(NSArray<NSNumber *> *args) { return exp(args[0].doubleValue); }];
}

@end
