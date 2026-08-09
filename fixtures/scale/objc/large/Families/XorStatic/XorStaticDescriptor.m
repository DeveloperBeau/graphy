#import "XorStaticDescriptor.h"
#import "XorStaticCipher.h"
#import "XorStaticVectors.h"

@implementation XorStaticDescriptor

- (NSString *)family {
    return @"xorstatic";
}

- (NSString *)suite {
    return @"stream";
}

- (id<CLCipher>)cipher {
    return [[XorStaticCipher alloc] init];
}

- (NSArray *)vectors {
    return [XorStaticVectors all];
}

@end
