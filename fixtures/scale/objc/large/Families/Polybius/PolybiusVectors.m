#import "PolybiusVectors.h"
#import "CLTestVector.h"

@implementation PolybiusVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"DZCMRCVREEDX"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"WNNCJAXICVVGAVHT"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"GKOQCVOFFIHCGMTHK"]];
    return vectors;
}

@end
