#import "BeaufortVectors.h"
#import "CLTestVector.h"

@implementation BeaufortVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"JDEMPYPJUSPH"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"CRPCHWRASJHQIBLV"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"MOQQARIXVWTMOSXJK"]];
    return vectors;
}

@end
