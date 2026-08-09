#import "GronsfeldDescriptor.h"
#import "GronsfeldCipher.h"
#import "GronsfeldVectors.h"

@implementation GronsfeldDescriptor

- (NSString *)family {
    return @"gronsfeld";
}

- (NSString *)suite {
    return @"polyalphabetic";
}

- (id<CLCipher>)cipher {
    return [[GronsfeldCipher alloc] init];
}

- (NSArray *)vectors {
    return [GronsfeldVectors all];
}

@end
