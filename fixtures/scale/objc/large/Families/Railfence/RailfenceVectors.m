#import "RailfenceVectors.h"
#import "CLTestVector.h"

@implementation RailfenceVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"HDGQVGZVIIHB"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"ARRGNEBMGZZKEZLX"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"KOSUGZSJJMLGKQXLO"]];
    return vectors;
}

@end
