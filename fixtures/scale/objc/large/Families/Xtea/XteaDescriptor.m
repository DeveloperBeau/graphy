#import "XteaDescriptor.h"
#import "XteaCipher.h"
#import "XteaVectors.h"

@implementation XteaDescriptor

- (NSString *)family {
    return @"xtea";
}

- (NSString *)suite {
    return @"block";
}

- (id<CLCipher>)cipher {
    return [[XteaCipher alloc] init];
}

- (NSArray *)vectors {
    return [XteaVectors all];
}

@end
