#import <Foundation/Foundation.h>

// Known-answer test data captured from AtbashCipher's own -encode:.
@interface AtbashVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via AtbashDescriptor.
+ (NSArray *)all;

@end
