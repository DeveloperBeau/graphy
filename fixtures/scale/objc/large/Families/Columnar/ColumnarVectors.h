#import <Foundation/Foundation.h>

// Known-answer test data captured from ColumnarCipher's own -encode:.
@interface ColumnarVectors : NSObject

// Array of CLTestVector; consumed by both the correctness and
// benchmark engines via ColumnarDescriptor.
+ (NSArray *)all;

@end
