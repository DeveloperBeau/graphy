#import <Foundation/Foundation.h>

// Known-answer test data captured from BeaufortCipher's own -encode:.
@interface BeaufortVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via BeaufortDescriptor.
+ (NSArray *)all;

@end
