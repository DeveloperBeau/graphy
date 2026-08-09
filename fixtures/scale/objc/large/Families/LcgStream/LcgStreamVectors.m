#import "LcgStreamVectors.h"
#import "CLTestVector.h"

@implementation LcgStreamVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"The quick brown fox jumps ov" expected:@"5c616f2b7d78676c7b3170617b6278377e76623b7668736f53014d55"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"cipher test corpus" expected:@"6b607a63697f2e7b75626633777a64676d6a"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"0123456789abcdef" expected:@"38383838383838382828737177717371"]];
    return vectors;
}

@end
