#import <Foundation/Foundation.h>

// Known-answer test data captured from Adler32Cipher's own -encode:.
@interface Adler32Vectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via Adler32Descriptor.
+ (NSArray *)all;

@end
