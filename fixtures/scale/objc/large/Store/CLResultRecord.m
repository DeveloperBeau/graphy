#import "CLResultRecord.h"

@implementation CLResultRecord

- (NSString *)toLine {
    return [NSString stringWithFormat:@"%@\t%@\t%@", self.family, self.suite, self.passed ? @"1" : @"0"];
}

+ (instancetype)fromLine:(NSString *)line {
    NSArray<NSString *> *parts = [line componentsSeparatedByString:@"\t"];
    CLResultRecord *record = [[CLResultRecord alloc] init];
    record.family = parts[0];
    record.suite = parts[1];
    record.passed = [parts[2] isEqualToString:@"1"];
    return record;
}

@end
