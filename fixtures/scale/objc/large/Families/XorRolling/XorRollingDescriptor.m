#import "XorRollingDescriptor.h"
#import "XorRollingCipher.h"
#import "XorRollingVectors.h"

@implementation XorRollingDescriptor

- (NSString *)family {
    return @"xorrolling";
}

- (NSString *)suite {
    return @"stream";
}

- (id<CLCipher>)cipher {
    return [[XorRollingCipher alloc] init];
}

- (NSArray *)vectors {
    return [XorRollingVectors all];
}

@end
