#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface CCVariableRef : NSObject <CCNode>

@property (nonatomic, copy) NSString *name;

+ (instancetype)refWithName:(NSString *)name;

@end
