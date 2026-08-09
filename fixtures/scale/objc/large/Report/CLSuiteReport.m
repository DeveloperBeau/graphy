#import "CLSuiteReport.h"
#import "CLTableRenderer.h"
#import "CLSuiteMap.h"

@implementation CLSuiteReport

- (NSString *)build:(NSArray *)outcomes {
    CLTableRenderer *table = [[CLTableRenderer alloc] init];
    [table addRow:@[@"suite", @"families"]];
    NSDictionary *grouped = [CLSuiteMap grouped];
    for (NSString *suite in [CLSuiteMap suiteNames]) {
        NSArray *members = grouped[suite];
        [table addRow:@[suite, [NSString stringWithFormat:@"%lu", (unsigned long)members.count]]];
    }
    return [table render];
}

@end
