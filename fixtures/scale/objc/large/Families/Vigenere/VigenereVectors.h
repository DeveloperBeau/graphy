#import <Foundation/Foundation.h>

// Known-answer test data captured from VigenereCipher's own -encode:.
@interface VigenereVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via VigenereDescriptor.
+ (NSArray *)all;

@end
