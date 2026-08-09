#import <Foundation/Foundation.h>

// Known-answer test data captured from PolybiusCipher's own -encode:.
@interface PolybiusVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via PolybiusDescriptor.
+ (NSArray *)all;

@end
