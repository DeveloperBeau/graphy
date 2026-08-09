#import "AffineDescriptor.h"
#import "AffineCipher.h"
#import "AffineVectors.h"

@implementation AffineDescriptor

- (NSString *)family {
    return @"affine";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[AffineCipher alloc] init];
}

- (NSArray *)vectors {
    return [AffineVectors all];
}

@end
