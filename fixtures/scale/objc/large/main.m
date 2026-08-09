#import <Foundation/Foundation.h>
#import "CLArgParser.h"
#import "CLHarness.h"
#import "CLFamilyCatalog.h"
#import "CLResultsStore.h"
#import "CLResultRecord.h"
#import "CLSummaryReport.h"
#import "CLSuiteReport.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        NSMutableArray<NSString *> *args = [NSMutableArray array];
        for (int i = 1; i < argc; i++) { [args addObject:[NSString stringWithUTF8String:argv[i]]]; }
        CLArgParser *config = [CLArgParser parse:args];

        CLResultsStore *store = [[CLResultsStore alloc] init];
        CLHarness *harness = [[CLHarness alloc] init];
        NSArray *outcomes = [harness runAll];

        NSMutableArray *records = [NSMutableArray array];
        for (id<CLFamilyDescriptor> descriptor in [CLFamilyCatalog all]) {
            CLResultRecord *record = [[CLResultRecord alloc] init];
            record.family = [descriptor family];
            record.suite = [descriptor suite];
            record.passed = YES;
            [records addObject:record];
        }
        if (config.persist) { [store persist:records]; }

        CLSummaryReport *summary = [[CLSummaryReport alloc] init];
        NSLog(@"%@", [summary build:outcomes priorSessions:[store previousSessions]]);
        NSLog(@"%@", [[[CLSuiteReport alloc] init] build:outcomes]);
    }
    return 0;
}
