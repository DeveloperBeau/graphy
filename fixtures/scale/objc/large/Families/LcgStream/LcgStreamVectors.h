#import <Foundation/Foundation.h>

// Known-answer test data captured from LcgStreamCipher's own -encode:.
@interface LcgStreamVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via LcgStreamDescriptor.
+ (NSArray *)all;

@end
