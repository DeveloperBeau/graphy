#import <Foundation/Foundation.h>

// Known-answer test data captured from Crc32Cipher's own -encode:.
@interface Crc32Vectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via Crc32Descriptor.
+ (NSArray *)all;

@end
