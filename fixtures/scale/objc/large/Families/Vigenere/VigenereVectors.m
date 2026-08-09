#import "VigenereVectors.h"
#import "CLTestVector.h"

@implementation VigenereVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"HCENRBTOAZXQ"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"AQPDJZVFYQPZSMXI"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"KNQRCUMCBDBVYDJWY"]];
    return vectors;
}

@end
