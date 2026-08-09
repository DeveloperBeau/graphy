#import <Foundation/Foundation.h>

// Per-suite family counts, grouped via CLSuiteMap; complements
// CLSummaryReport's flat pass/fail totals with a per-category view.
// Printed last, after the summary, in main's output.
@interface CLSuiteReport : NSObject

- (NSString *)build:(NSArray *)outcomes;

@end
