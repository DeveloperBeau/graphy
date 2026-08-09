#import "CCHistoryEntry.h"

@implementation CCHistoryEntry

+ (instancetype)entryWithExpression:(NSString *)expression value:(double)value {
    CCHistoryEntry *entry = [[CCHistoryEntry alloc] init];
    entry.expression = expression;
    entry.value = value;
    return entry;
}

@end
