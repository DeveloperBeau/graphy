#import <Foundation/Foundation.h>

// Known-answer test data captured from SdbmCipher's own -encode:.
@interface SdbmVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via SdbmDescriptor.
+ (NSArray *)all;

@end
