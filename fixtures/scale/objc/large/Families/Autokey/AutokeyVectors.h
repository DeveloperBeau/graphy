#import <Foundation/Foundation.h>

// Known-answer test data captured from AutokeyCipher's own -encode:.
@interface AutokeyVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via AutokeyDescriptor.
+ (NSArray *)all;

@end
