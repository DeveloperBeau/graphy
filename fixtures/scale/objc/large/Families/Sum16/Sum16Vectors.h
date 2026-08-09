#import <Foundation/Foundation.h>

// Known-answer test data captured from Sum16Cipher's own -encode:.
@interface Sum16Vectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via Sum16Descriptor.
+ (NSArray *)all;

@end
