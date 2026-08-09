#import "ColumnarVectors.h"
#import "CLTestVector.h"

@implementation ColumnarVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"JEGPTDVQCBZS"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"CSRFLBXHASRBUOZK"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"MPSTEWOEDFDXAFLYA"]];
    return vectors;
}

@end
