#import <Foundation/Foundation.h>

// Known-answer test data captured from Rc4Cipher's own -encode:.
@interface Rc4Vectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via Rc4Descriptor.
+ (NSArray *)all;

@end
