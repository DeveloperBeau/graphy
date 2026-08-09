#import "XorRollingVectors.h"
#import "CLTestVector.h"

@implementation XorRollingVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"The quick brown fox jumps ov" expected:@"526f6d297b7e656e652f72637d647a3570786039706e716d6d3f4f57"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"cipher test corpus" expected:@"656e78616f792c796b7c6431717c66656364"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"0123456789abcdef" expected:@"36363a3a3e3e3a3a3636717371777173"]];
    return vectors;
}

@end
