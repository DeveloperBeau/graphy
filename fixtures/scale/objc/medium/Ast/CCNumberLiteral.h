#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCNumberLiteral : NSObject <CCNode>

@property (nonatomic, assign) double value;

+ (instancetype)literalWithValue:(double)value;

@end
