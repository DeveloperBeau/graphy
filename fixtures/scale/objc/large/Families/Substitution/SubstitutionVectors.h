#import <Foundation/Foundation.h>

// Known-answer test data captured from SubstitutionCipher's own -encode:.
@interface SubstitutionVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via SubstitutionDescriptor.
+ (NSArray *)all;

@end
