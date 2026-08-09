#import "CCTrigFunctions.h"

@implementation CCTrigFunctions

+ (void)installInto:(CCFunctionRegistry *)registry {
    [registry define:@"sin" body:^double(NSArray<NSNumber *> *args) { return sin(args[0].doubleValue); }];
    [registry define:@"cos" body:^double(NSArray<NSNumber *> *args) { return cos(args[0].doubleValue); }];
    [registry define:@"tan" body:^double(NSArray<NSNumber *> *args) { return tan(args[0].doubleValue); }];
}

@end
