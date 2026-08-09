#import "TrithemiusVectors.h"
#import "CLTestVector.h"

@implementation TrithemiusVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"EADNSDWSFFEY"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"XOODKBYJDWWHBWIU"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"HLPRDWPGGJIDHNUIL"]];
    return vectors;
}

@end
