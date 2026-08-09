#import "Crc32Descriptor.h"
#import "Crc32Cipher.h"
#import "Crc32Vectors.h"

@implementation Crc32Descriptor

- (NSString *)family {
    return @"crc32";
}

- (NSString *)suite {
    return @"hash";
}

- (id<CLCipher>)cipher {
    return [[Crc32Cipher alloc] init];
}

- (NSArray *)vectors {
    return [Crc32Vectors all];
}

@end
