#import "Djb2Descriptor.h"
#import "Djb2Cipher.h"
#import "Djb2Vectors.h"

@implementation Djb2Descriptor

- (NSString *)family {
    return @"djb2";
}

- (NSString *)suite {
    return @"hash";
}

- (id<CLCipher>)cipher {
    return [[Djb2Cipher alloc] init];
}

- (NSArray *)vectors {
    return [Djb2Vectors all];
}

@end
