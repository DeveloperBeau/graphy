#import <Foundation/Foundation.h>

// Pulled out of CCEvaluator so the four arithmetic operators can be
// unit-exercised without constructing a full AST.
@interface CCBinaryMath : NSObject

// Division by zero returns 0 rather than raising or trapping.
+ (double)apply:(NSString *)op left:(double)left right:(double)right;

@end
