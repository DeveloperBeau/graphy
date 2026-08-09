#import <Foundation/Foundation.h>

// Pass/fail counts plus a rough "sessions run before this one" figure
// pulled from CLResultsStore; printed first, above the suite table.
// See CLSuiteReport for the complementary per-suite breakdown.
@interface CLSummaryReport : NSObject

- (NSString *)build:(NSArray *)outcomes priorSessions:(NSInteger)priorSessions;

@end
