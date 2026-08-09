#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCUnaryOp : NSObject <CCNode>

@property (nonatomic, copy) NSString *op;
@property (nonatomic, strong) id<CCNode> operand;

+ (instancetype)opWithSymbol:(NSString *)op operand:(id<CCNode>)operand;

@end
