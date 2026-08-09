#import <Foundation/Foundation.h>

// Holds variable bindings created by ":=" assignments during a REPL
// session; unset names resolve to 0 rather than raising.
@interface CCEnvironment : NSObject

- (void)assign:(NSString *)name value:(double)value;
- (double)resolve:(NSString *)name;
- (NSArray<NSString *> *)names;

@end
