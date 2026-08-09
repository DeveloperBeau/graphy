#import <Foundation/Foundation.h>

// Known-answer test data captured from XorStaticCipher's own -encode:.
@interface XorStaticVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via XorStaticDescriptor.
+ (NSArray *)all;

@end
