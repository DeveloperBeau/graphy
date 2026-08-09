#import <Foundation/Foundation.h>

// Every AST node produced by CCParser conforms to this protocol so
// CCEvaluator can dispatch on kind without a class hierarchy.
@protocol CCNode <NSObject>

// Renders the node back to a source-like fragment; used for history
// logging and for error messages raised during evaluation.
- (NSString *)describe;

@end
