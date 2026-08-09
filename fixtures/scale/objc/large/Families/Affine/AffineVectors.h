#import <Foundation/Foundation.h>

// Known-answer test data captured from AffineCipher's own -encode:.
@interface AffineVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via AffineDescriptor.
+ (NSArray *)all;

@end
