#import "SdbmCipher.h"

@implementation SdbmCipher

- (instancetype)init {
    if ((self = [super init])) {
        _seed = 2166136261u; _prime = 16777619u;
    }
    return self;
}

- (NSString *)name {
    return @"sdbm";
}

- (NSString *)encode:(NSString *)plaintext {
    uint32_t acc = self.seed;
    NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char *bytes = data.bytes;
    for (NSUInteger i = 0; i < data.length; i++) {
        acc = (acc ^ bytes[i]) * self.prime;
    }
    return [NSString stringWithFormat:@"%08x", acc];
}

- (NSString *)decode:(NSString *)ciphertext {
    return [@"digest:" stringByAppendingString:ciphertext];
}

@end
