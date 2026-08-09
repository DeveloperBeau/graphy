#import <Foundation/Foundation.h>

// Known-answer test data captured from KeywordCipher's own -encode:.
@interface KeywordVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via KeywordDescriptor.
+ (NSArray *)all;

@end
