#import "CLHarness.h"
#import "CLCorrectnessEngine.h"
#import "CLFamilyCatalog.h"
#import "CLVectorOutcome.h"

@implementation CLHarness

- (NSArray *)runAll {
    CLCorrectnessEngine *engine = [[CLCorrectnessEngine alloc] init];
    NSMutableArray *outcomes = [NSMutableArray array];
    NSInteger done = 0;
    NSArray *descriptors = [CLFamilyCatalog all];
    for (id<CLFamilyDescriptor> descriptor in descriptors) {
        CLVectorOutcome *outcome = [engine verify:[descriptor cipher] vectors:[descriptor vectors]];
        done++;
        fprintf(stderr, "\r[%ld/%ld] %s %s        ", (long)done, (long)descriptors.count,
                outcome.passed ? "ok " : "BAD", [descriptor.family UTF8String]);
        [outcomes addObject:outcome];
    }
    fprintf(stderr, "\n");
    return outcomes;
}

@end
