#import "CLCorrectnessEngine.h"
#import "CLTestVector.h"

@implementation CLCorrectnessEngine

- (CLVectorOutcome *)verify:(id<CLCipher>)cipher vectors:(NSArray *)vectors {
    for (CLTestVector *vector in vectors) {
        NSString *encoded = [cipher encode:vector.plaintext];
        if (![encoded isEqualToString:vector.expected]) {
            NSString *detail = [@"encode mismatch for " stringByAppendingString:vector.plaintext];
            return [CLVectorOutcome outcomeWithFamily:[cipher name] passed:NO detail:detail];
        }
        NSString *decoded = [cipher decode:encoded];
        if (decoded.length == 0 && vector.plaintext.length > 0) {
            return [CLVectorOutcome outcomeWithFamily:[cipher name] passed:NO detail:@"empty decode"];
        }
    }
    return [CLVectorOutcome outcomeWithFamily:[cipher name] passed:YES detail:@"ok"];
}

@end
