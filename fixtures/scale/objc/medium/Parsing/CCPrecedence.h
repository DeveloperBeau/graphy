#import <Foundation/Foundation.h>

@interface CCPrecedence : NSObject

// Higher binds tighter; unknown operators sort below everything.
// Consulted by CCParser's expression loop on every operator token
// to decide when to fold the running left-hand side.
+ (NSInteger)of:(NSString *)op;

@end
