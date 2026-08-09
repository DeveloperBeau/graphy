#import "CCHistoryLog.h"

@interface CCHistoryLog ()
@property (nonatomic, strong) NSMutableArray<CCHistoryEntry *> *entries;
@end

@implementation CCHistoryLog

- (instancetype)init {
    if ((self = [super init])) {
        _entries = [NSMutableArray array];
    }
    return self;
}

- (CCHistoryEntry *)appendExpression:(NSString *)expression value:(double)value {
    CCHistoryEntry *entry = [CCHistoryEntry entryWithExpression:expression value:value];
    [self.entries addObject:entry];
    return entry;
}

- (NSArray<CCHistoryEntry *> *)recent:(NSUInteger)count {
    NSUInteger start = self.entries.count > count ? self.entries.count - count : 0;
    return [self.entries subarrayWithRange:NSMakeRange(start, self.entries.count - start)];
}

- (NSUInteger)count {
    return self.entries.count;
}

@end
