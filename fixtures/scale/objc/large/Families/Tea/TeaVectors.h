#import <Foundation/Foundation.h>

// Known-answer test data captured from TeaCipher's own -encode:.
@interface TeaVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via TeaDescriptor.
+ (NSArray *)all;

@end
