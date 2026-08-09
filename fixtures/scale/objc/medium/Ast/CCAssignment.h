#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCAssignment : NSObject <CCNode>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id<CCNode> value;

+ (instancetype)assignName:(NSString *)name value:(id<CCNode>)value;

@end
