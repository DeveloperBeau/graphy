#import "XteaCipher.h"

@implementation XteaCipher

- (instancetype)init {
    if ((self = [super init])) {
        _rounds = 2;
    }
    return self;
}

- (NSString *)name {
    return @"xtea";
}

- (NSString *)encode:(NSString *)plaintext {
    NSMutableString *out = [NSMutableString string];
    NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char *bytes = data.bytes;
    for (NSUInteger i = 0; i < data.length; i++) {
        NSInteger rotated = ((bytes[i] << self.rounds) | (bytes[i] >> (8 - self.rounds))) & 0xFF;
        [out appendFormat:@"%02lx", (long)rotated];
    }
    return out;
}

- (NSString *)decode:(NSString *)ciphertext {
    NSMutableData *data = [NSMutableData data];
    for (NSUInteger i = 0; i + 1 < ciphertext.length; i += 2) {
        NSString *pair = [ciphertext substringWithRange:NSMakeRange(i, 2)];
        unsigned int value = 0;
        [[NSScanner scannerWithString:pair] scanHexInt:&value];
        unsigned char back = ((value >> self.rounds) | (value << (8 - self.rounds))) & 0xFF;
        [data appendBytes:&back length:1];
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
