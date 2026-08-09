#import "ScytaleVectors.h"
#import "CLTestVector.h"

@implementation ScytaleVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"ICDLOXOITROG"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"BQOBGVQZRIGPHAKU"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"LNPPZQHWUVSLNRWIJ"]];
    return vectors;
}

@end
