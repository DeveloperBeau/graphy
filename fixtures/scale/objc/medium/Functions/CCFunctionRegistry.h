#import <Foundation/Foundation.h>

typedef double (^CCBuiltin)(NSArray<NSNumber *> *args);

@interface CCFunctionRegistry : NSObject

- (void)define:(NSString *)name body:(CCBuiltin)body;
- (double)invoke:(NSString *)name arguments:(NSArray<NSNumber *> *)arguments;
- (NSArray<NSString *> *)names;

@end
