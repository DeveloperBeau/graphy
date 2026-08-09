#import "KeywordVectors.h"
#import "CLTestVector.h"

@implementation KeywordVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"FZAILULFQOLD"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"YNLYDSNWOFDMEXHR"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"IKMMWNETRSPIKOTFG"]];
    return vectors;
}

@end
