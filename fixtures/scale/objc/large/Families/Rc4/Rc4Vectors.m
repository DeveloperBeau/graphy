#import "Rc4Vectors.h"
#import "CLTestVector.h"

@implementation Rc4Vectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"The quick brown fox jumps ov" expected:@"53606c2a7a79646d643073607c637b367177613a7169706e6c004e54"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"cipher test corpus" expected:@"646179626e7e2d7a6a636532707b6766626b"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"0123456789abcdef" expected:@"37393b393f393b393729707070707070"]];
    return vectors;
}

@end
