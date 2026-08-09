#import "RotByteVectors.h"
#import "CLTestVector.h"

@implementation RotByteVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"The quick brown fox jumps ov" expected:@"576c6026767d6069602c6f7c60677f32757b6d367d6d746a683c7268"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"cipher test corpus" expected:@"606d756e627a297e6e7f792e6c7f63626667"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"0123456789abcdef" expected:@"33353735333d3f3d33356c6c6c747474"]];
    return vectors;
}

@end
