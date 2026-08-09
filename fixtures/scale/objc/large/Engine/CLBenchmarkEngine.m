#import "CLBenchmarkEngine.h"
#import "CLTestVector.h"

@implementation CLBenchmarkEngine

- (double)sample:(id<CLCipher>)cipher vectors:(NSArray *)vectors iterations:(NSInteger)iterations {
    NSDate *start = [NSDate date];
    for (NSInteger i = 0; i < iterations; i++) {
        for (CLTestVector *vector in vectors) {
            [cipher encode:vector.plaintext];
        }
    }
    return [[NSDate date] timeIntervalSinceDate:start] * 1e9;
}

@end
