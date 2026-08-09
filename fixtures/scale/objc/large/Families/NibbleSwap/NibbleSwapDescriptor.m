#import "NibbleSwapDescriptor.h"
#import "NibbleSwapCipher.h"
#import "NibbleSwapVectors.h"

@implementation NibbleSwapDescriptor

- (NSString *)family {
    return @"nibbleswap";
}

- (NSString *)suite {
    return @"stream";
}

- (id<CLCipher>)cipher {
    return [[NibbleSwapCipher alloc] init];
}

- (NSArray *)vectors {
    return [NibbleSwapVectors all];
}

@end
