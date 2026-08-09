#import "Fnv1a32Descriptor.h"
#import "Fnv1a32Cipher.h"
#import "Fnv1a32Vectors.h"

@implementation Fnv1a32Descriptor

- (NSString *)family {
    return @"fnv1a32";
}

- (NSString *)suite {
    return @"hash";
}

- (id<CLCipher>)cipher {
    return [[Fnv1a32Cipher alloc] init];
}

- (NSArray *)vectors {
    return [Fnv1a32Vectors all];
}

@end
