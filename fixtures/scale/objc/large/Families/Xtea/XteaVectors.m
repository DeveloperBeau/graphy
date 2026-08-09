#import "XteaVectors.h"
#import "CLTestVector.h"

@implementation XteaVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"The quick brown!" expected:@"51a19580c5d5a58dad8089c9bdddb984"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"0123456789abcdef" expected:@"c0c4c8ccd0d4d8dce0e485898d919599"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"silver marble owl padloc" expected:@"cda5b1d995c980b585c989b19580bdddb180c18591b1bd8d"]];
    return vectors;
}

@end
