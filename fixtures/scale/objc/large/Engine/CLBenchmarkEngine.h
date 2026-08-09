#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Returns elapsed nanoseconds for iterations passes over vectors;
// callers divide by iterations * vectors.count for a per-op figure.
@interface CLBenchmarkEngine : NSObject

- (double)sample:(id<CLCipher>)cipher vectors:(NSArray *)vectors iterations:(NSInteger)iterations;

@end
