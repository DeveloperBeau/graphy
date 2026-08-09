#import <Foundation/Foundation.h>

// Known-answer test data captured from Rot13Cipher's own -encode:.
@interface Rot13Vectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via Rot13Descriptor.
+ (NSArray *)all;

@end
