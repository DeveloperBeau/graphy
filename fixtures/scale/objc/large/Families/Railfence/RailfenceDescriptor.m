#import "RailfenceDescriptor.h"
#import "RailfenceCipher.h"
#import "RailfenceVectors.h"

@implementation RailfenceDescriptor

- (NSString *)family {
    return @"railfence";
}

- (NSString *)suite {
    return @"transposition";
}

- (id<CLCipher>)cipher {
    return [[RailfenceCipher alloc] init];
}

- (NSArray *)vectors {
    return [RailfenceVectors all];
}

@end
