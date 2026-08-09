#import "VigenereDescriptor.h"
#import "VigenereCipher.h"
#import "VigenereVectors.h"

@implementation VigenereDescriptor

- (NSString *)family {
    return @"vigenere";
}

- (NSString *)suite {
    return @"polyalphabetic";
}

- (id<CLCipher>)cipher {
    return [[VigenereCipher alloc] init];
}

- (NSArray *)vectors {
    return [VigenereVectors all];
}

@end
