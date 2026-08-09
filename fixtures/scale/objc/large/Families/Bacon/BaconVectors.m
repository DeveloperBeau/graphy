#import "BaconVectors.h"
#import "CLTestVector.h"

@implementation BaconVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"EYZHKTKEPNKC"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"XMKXCRMVNECLDWGQ"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"HJLLVMDSQROHJNSEF"]];
    return vectors;
}

@end
