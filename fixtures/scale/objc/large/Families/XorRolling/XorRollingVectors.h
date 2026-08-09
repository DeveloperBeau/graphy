#import <Foundation/Foundation.h>

// Known-answer test data captured from XorRollingCipher's own -encode:.
@interface XorRollingVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via XorRollingDescriptor.
+ (NSArray *)all;

@end
