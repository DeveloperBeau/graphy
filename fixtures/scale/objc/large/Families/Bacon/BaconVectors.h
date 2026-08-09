#import <Foundation/Foundation.h>

// Known-answer test data captured from BaconCipher's own -encode:.
@interface BaconVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via BaconDescriptor.
+ (NSArray *)all;

@end
