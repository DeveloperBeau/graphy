#import <Foundation/Foundation.h>

// A single known-answer pair used to check a CLCipher implementation.
@interface CLTestVector : NSObject

@property (nonatomic, copy) NSString *plaintext;
@property (nonatomic, copy) NSString *expected;

+ (instancetype)vectorWithPlaintext:(NSString *)plaintext expected:(NSString *)expected;

@end
