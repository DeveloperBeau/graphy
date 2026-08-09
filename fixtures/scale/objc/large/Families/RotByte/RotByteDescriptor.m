#import "RotByteDescriptor.h"
#import "RotByteCipher.h"
#import "RotByteVectors.h"

@implementation RotByteDescriptor

- (NSString *)family {
    return @"rotbyte";
}

- (NSString *)suite {
    return @"stream";
}

- (id<CLCipher>)cipher {
    return [[RotByteCipher alloc] init];
}

- (NSArray *)vectors {
    return [RotByteVectors all];
}

@end
