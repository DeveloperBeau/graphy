#import <Foundation/Foundation.h>

// Known-answer test data captured from Djb2Cipher's own -encode:.
@interface Djb2Vectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via Djb2Descriptor.
+ (NSArray *)all;

@end
