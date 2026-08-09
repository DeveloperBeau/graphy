#import "SdbmDescriptor.h"
#import "SdbmCipher.h"
#import "SdbmVectors.h"

@implementation SdbmDescriptor

- (NSString *)family {
    return @"sdbm";
}

- (NSString *)suite {
    return @"hash";
}

- (id<CLCipher>)cipher {
    return [[SdbmCipher alloc] init];
}

- (NSArray *)vectors {
    return [SdbmVectors all];
}

@end
