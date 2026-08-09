#import "NibbleSwapVectors.h"
#import "CLTestVector.h"

@implementation NibbleSwapVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"The quick brown fox jumps ov" expected:@"5d626e2c7c7b66737a3271667a6179387f75633c776b725052024c52"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"cipher test corpus" expected:@"6a637b64687c2f6474616734767965686c69"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"0123456789abcdef" expected:@"393b393f393b3927292b72767672727e"]];
    return vectors;
}

@end
