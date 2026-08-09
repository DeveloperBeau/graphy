#import <Foundation/Foundation.h>

// Known-answer test data captured from RailfenceCipher's own -encode:.
@interface RailfenceVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via RailfenceDescriptor.
+ (NSArray *)all;

@end
