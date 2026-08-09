#import "Adler32Descriptor.h"
#import "Adler32Cipher.h"
#import "Adler32Vectors.h"

@implementation Adler32Descriptor

- (NSString *)family {
    return @"adler32";
}

- (NSString *)suite {
    return @"hash";
}

- (id<CLCipher>)cipher {
    return [[Adler32Cipher alloc] init];
}

- (NSArray *)vectors {
    return [Adler32Vectors all];
}

@end
