#import "TeaDescriptor.h"
#import "TeaCipher.h"
#import "TeaVectors.h"

@implementation TeaDescriptor

- (NSString *)family {
    return @"tea";
}

- (NSString *)suite {
    return @"block";
}

- (id<CLCipher>)cipher {
    return [[TeaCipher alloc] init];
}

- (NSArray *)vectors {
    return [TeaVectors all];
}

@end
