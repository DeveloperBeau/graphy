#import "XorRollingCipher.h"

@implementation XorRollingCipher

- (instancetype)init {
    if ((self = [super init])) {
        _mask = 6;
    }
    return self;
}

- (NSString *)name {
    return @"xorrolling";
}

- (NSString *)encode:(NSString *)plaintext {
    NSMutableString *out = [NSMutableString string];
    NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char *bytes = data.bytes;
    for (NSUInteger i = 0; i < data.length; i++) {
        NSInteger value = (bytes[i] ^ (self.mask + (NSInteger)i)) & 0xFF;
        [out appendFormat:@"%02lx", (long)value];
    }
    return out;
}

- (NSString *)decode:(NSString *)ciphertext {
    NSMutableData *data = [NSMutableData data];
    for (NSUInteger i = 0; i + 1 < ciphertext.length; i += 2) {
        NSString *pair = [ciphertext substringWithRange:NSMakeRange(i, 2)];
        unsigned int value = 0;
        [[NSScanner scannerWithString:pair] scanHexInt:&value];
        unsigned char decoded = (value ^ (self.mask + (NSInteger)(i / 2))) & 0xFF;
        [data appendBytes:&decoded length:1];
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
