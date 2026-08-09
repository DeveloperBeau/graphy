#import <Foundation/Foundation.h>

// Known-answer test data captured from Fnv1a32Cipher's own -encode:.
@interface Fnv1a32Vectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via Fnv1a32Descriptor.
+ (NSArray *)all;

@end
