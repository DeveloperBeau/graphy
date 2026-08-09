#import "SubstitutionVectors.h"
#import "CLTestVector.h"

@implementation SubstitutionVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"GBDMQASNZYWP"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"ZPOCIYUEXPOYRLWH"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"JMPQBTLBACAUXCIVX"]];
    return vectors;
}

@end
