#import <Foundation/Foundation.h>

// Known-answer test data captured from FeistelCipher's own -encode:.
@interface FeistelVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via FeistelDescriptor.
+ (NSArray *)all;

@end
