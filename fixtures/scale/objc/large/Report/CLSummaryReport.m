#import "CLSummaryReport.h"
#import "CLTableRenderer.h"
#import "CLVectorOutcome.h"

@implementation CLSummaryReport

- (NSString *)build:(NSArray *)outcomes priorSessions:(NSInteger)priorSessions {
    NSInteger passed = 0;
    for (CLVectorOutcome *outcome in outcomes) { if (outcome.passed) { passed++; } }
    CLTableRenderer *table = [[CLTableRenderer alloc] init];
    [table addRow:@[@"metric", @"value"]];
    [table addRow:@[@"families", [NSString stringWithFormat:@"%lu", (unsigned long)outcomes.count]]];
    [table addRow:@[@"passed", [NSString stringWithFormat:@"%ld", (long)passed]]];
    [table addRow:@[@"prior sessions", [NSString stringWithFormat:@"%ld", (long)priorSessions]]];
    return [table render];
}

@end
