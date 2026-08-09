#import "CLTestVector.h"

@implementation CLTestVector

+ (instancetype)vectorWithPlaintext:(NSString *)plaintext expected:(NSString *)expected {
    CLTestVector *vector = [[CLTestVector alloc] init];
    vector.plaintext = plaintext;
    vector.expected = expected;
    return vector;
}

@end
