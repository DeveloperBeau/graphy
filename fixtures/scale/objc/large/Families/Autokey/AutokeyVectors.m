#import "AutokeyVectors.h"
#import "CLTestVector.h"

@implementation AutokeyVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"IEHRWHAWJJIC"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"BSSHOFCNHAALFAMY"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"LPTVHATKKNMHLRYMP"]];
    return vectors;
}

@end
