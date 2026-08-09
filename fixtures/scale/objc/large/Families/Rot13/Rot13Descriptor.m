#import "Rot13Descriptor.h"
#import "Rot13Cipher.h"
#import "Rot13Vectors.h"

@implementation Rot13Descriptor

- (NSString *)family {
    return @"rot13";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[Rot13Cipher alloc] init];
}

- (NSArray *)vectors {
    return [Rot13Vectors all];
}

@end
