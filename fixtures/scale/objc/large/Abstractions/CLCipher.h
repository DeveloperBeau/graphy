#import <Foundation/Foundation.h>

// Implemented once per cipher family under Families/<Name>/<Name>Cipher.h.
@protocol CLCipher <NSObject>

// Short identifier used for reporting and registry lookups.
- (NSString *)name;

// Transforms plaintext into the family's ciphertext representation.
- (NSString *)encode:(NSString *)plaintext;

// Reverses encode:; not required to be lossless for hash families.
- (NSString *)decode:(NSString *)ciphertext;

@end
