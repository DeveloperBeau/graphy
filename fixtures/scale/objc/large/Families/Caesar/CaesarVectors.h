#import <Foundation/Foundation.h>

// Known-answer test data captured from CaesarCipher's own -encode:.
@interface CaesarVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via CaesarDescriptor.
+ (NSArray *)all;

@end
