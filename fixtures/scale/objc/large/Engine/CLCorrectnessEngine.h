#import <Foundation/Foundation.h>
#import "CLCipher.h"
#import "CLVectorOutcome.h"

// Shared across every family; CLHarness owns one instance and calls
// verify:vectors: once per registered descriptor.
@interface CLCorrectnessEngine : NSObject

- (CLVectorOutcome *)verify:(id<CLCipher>)cipher vectors:(NSArray *)vectors;

@end
