#import "BaconDescriptor.h"
#import "BaconCipher.h"
#import "BaconVectors.h"

@implementation BaconDescriptor

- (NSString *)family {
    return @"bacon";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[BaconCipher alloc] init];
}

- (NSArray *)vectors {
    return [BaconVectors all];
}

@end
