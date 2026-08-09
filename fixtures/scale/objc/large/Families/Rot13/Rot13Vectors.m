#import "Rot13Vectors.h"
#import "CLTestVector.h"

@implementation Rot13Vectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"EZBKOYQLXWUN"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"XNMAGWSCVNMWPJUF"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"HKNOZRJZYAYSVAGTV"]];
    return vectors;
}

@end
