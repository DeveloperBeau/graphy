#import <Foundation/Foundation.h>

// Known-answer test data captured from TrithemiusCipher's own -encode:.
@interface TrithemiusVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via TrithemiusDescriptor.
+ (NSArray *)all;

@end
