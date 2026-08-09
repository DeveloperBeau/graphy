#import "GronsfeldVectors.h"
#import "CLTestVector.h"

@implementation GronsfeldVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"DYAJNXPKWVTM"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"WMLZFVRBUMLVOITE"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"GJMNYQIYXZXRUZFSU"]];
    return vectors;
}

@end
