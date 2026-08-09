#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCFunctionCall : NSObject <CCNode>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<id<CCNode>> *arguments;

+ (instancetype)callWithName:(NSString *)name arguments:(NSArray<id<CCNode>> *)arguments;

@end
