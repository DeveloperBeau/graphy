#import <Foundation/Foundation.h>

// Known-answer test data captured from RotByteCipher's own -encode:.
@interface RotByteVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via RotByteDescriptor.
+ (NSArray *)all;

@end
