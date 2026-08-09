#import "CLVectorOutcome.h"

@implementation CLVectorOutcome

+ (instancetype)outcomeWithFamily:(NSString *)family passed:(BOOL)passed detail:(NSString *)detail {
    CLVectorOutcome *outcome = [[CLVectorOutcome alloc] init];
    outcome.family = family;
    outcome.passed = passed;
    outcome.detail = detail;
    return outcome;
}

@end
