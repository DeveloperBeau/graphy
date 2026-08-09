#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCBinaryOp : NSObject <CCNode>

@property (nonatomic, copy) NSString *op;
@property (nonatomic, strong) id<CCNode> left;
@property (nonatomic, strong) id<CCNode> right;

+ (instancetype)opWithSymbol:(NSString *)op left:(id<CCNode>)left right:(id<CCNode>)right;

@end
