#import <Foundation/Foundation.h>

// Known-answer test data captured from GronsfeldCipher's own -encode:.
@interface GronsfeldVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via GronsfeldDescriptor.
+ (NSArray *)all;

@end
