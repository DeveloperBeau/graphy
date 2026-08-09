#import "Sum16Vectors.h"
#import "CLTestVector.h"

@implementation Sum16Vectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"abc" expected:@"1a47e90b"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"hello world" expected:@"d58b3fa7"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"The quick brown fox jumps over the lazy dog" expected:@"048fff90"]];
    return vectors;
}

@end
