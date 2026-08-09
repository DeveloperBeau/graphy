#import "Rc4Descriptor.h"
#import "Rc4Cipher.h"
#import "Rc4Vectors.h"

@implementation Rc4Descriptor

- (NSString *)family {
    return @"rc4";
}

- (NSString *)suite {
    return @"stream";
}

- (id<CLCipher>)cipher {
    return [[Rc4Cipher alloc] init];
}

- (NSArray *)vectors {
    return [Rc4Vectors all];
}

@end
