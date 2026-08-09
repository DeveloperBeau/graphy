#import <Foundation/Foundation.h>

// Known-answer test data captured from NibbleSwapCipher's own -encode:.
@interface NibbleSwapVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via NibbleSwapDescriptor.
+ (NSArray *)all;

@end
