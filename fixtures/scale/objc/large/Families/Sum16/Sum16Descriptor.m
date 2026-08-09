#import "Sum16Descriptor.h"
#import "Sum16Cipher.h"
#import "Sum16Vectors.h"

@implementation Sum16Descriptor

- (NSString *)family {
    return @"sum16";
}

- (NSString *)suite {
    return @"hash";
}

- (id<CLCipher>)cipher {
    return [[Sum16Cipher alloc] init];
}

- (NSArray *)vectors {
    return [Sum16Vectors all];
}

@end
