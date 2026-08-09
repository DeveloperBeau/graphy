#import <Foundation/Foundation.h>

@interface CCHistoryEntry : NSObject

@property (nonatomic, copy) NSString *expression;
@property (nonatomic, assign) double value;

+ (instancetype)entryWithExpression:(NSString *)expression value:(double)value;

@end
