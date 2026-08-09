#import <Foundation/Foundation.h>
#import "CCNode.h"
#import "CCEnvironment.h"
#import "CCFunctionRegistry.h"

@interface CCEvaluator : NSObject

- (instancetype)initWithEnvironment:(CCEnvironment *)environment functions:(CCFunctionRegistry *)functions;
- (double)eval:(id<CCNode>)node;

@end
