#import <Foundation/Foundation.h>

// Known-answer test data captured from BlockReverseCipher's own -encode:.
@interface BlockReverseVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via BlockReverseDescriptor.
+ (NSArray *)all;

@end
