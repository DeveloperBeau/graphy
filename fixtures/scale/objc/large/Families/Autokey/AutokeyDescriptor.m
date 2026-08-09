#import "AutokeyDescriptor.h"
#import "AutokeyCipher.h"
#import "AutokeyVectors.h"

@implementation AutokeyDescriptor

- (NSString *)family {
    return @"autokey";
}

- (NSString *)suite {
    return @"polyalphabetic";
}

- (id<CLCipher>)cipher {
    return [[AutokeyCipher alloc] init];
}

- (NSArray *)vectors {
    return [AutokeyVectors all];
}

@end
