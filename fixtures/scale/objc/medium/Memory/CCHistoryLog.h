#import <Foundation/Foundation.h>
#import "CCHistoryEntry.h"

@interface CCHistoryLog : NSObject

- (CCHistoryEntry *)appendExpression:(NSString *)expression value:(double)value;
- (NSArray<CCHistoryEntry *> *)recent:(NSUInteger)count;
- (NSUInteger)count;

@end
