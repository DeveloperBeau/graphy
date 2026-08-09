#import <Foundation/Foundation.h>

// Known-answer test data captured from ScytaleCipher's own -encode:.
@interface ScytaleVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via ScytaleDescriptor.
+ (NSArray *)all;

@end
