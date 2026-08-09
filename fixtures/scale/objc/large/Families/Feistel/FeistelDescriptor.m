#import "FeistelDescriptor.h"
#import "FeistelCipher.h"
#import "FeistelVectors.h"

@implementation FeistelDescriptor

- (NSString *)family {
    return @"feistel";
}

- (NSString *)suite {
    return @"block";
}

- (id<CLCipher>)cipher {
    return [[FeistelCipher alloc] init];
}

- (NSArray *)vectors {
    return [FeistelVectors all];
}

@end
