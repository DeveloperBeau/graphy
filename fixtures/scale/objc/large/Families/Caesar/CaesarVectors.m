#import "CaesarVectors.h"
#import "CLTestVector.h"

@implementation CaesarVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"DXYGJSJDOMJB"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"WLJWBQLUMDBKCVFP"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"GIKKULCRPQNGIMRDE"]];
    return vectors;
}

@end
