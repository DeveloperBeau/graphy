#import "VigenereCipher.h"

@implementation VigenereCipher

- (instancetype)init {
    if ((self = [super init])) {
        _shift = 7; _step = 2;
    }
    return self;
}

- (NSString *)name {
    return @"vigenere";
}

- (NSString *)encode:(NSString *)plaintext {
    NSMutableString *out = [NSMutableString string];
    for (NSUInteger i = 0; i < plaintext.length; i++) {
        unichar ch = [plaintext characterAtIndex:i];
        if (ch < 'A' || ch > 'Z') { [out appendFormat:@"%C", ch]; continue; }
        NSInteger shifted = ((ch - 'A') + self.shift + (NSInteger)i * self.step) % 26;
        [out appendFormat:@"%c", (char)('A' + shifted)];
    }
    return out;
}

- (NSString *)decode:(NSString *)ciphertext {
    NSMutableString *out = [NSMutableString string];
    for (NSUInteger i = 0; i < ciphertext.length; i++) {
        unichar ch = [ciphertext characterAtIndex:i];
        if (ch < 'A' || ch > 'Z') { [out appendFormat:@"%C", ch]; continue; }
        NSInteger shifted = ((ch - 'A') - self.shift - (NSInteger)i * self.step + 2600) % 26;
        [out appendFormat:@"%c", (char)('A' + shifted)];
    }
    return out;
}

@end
