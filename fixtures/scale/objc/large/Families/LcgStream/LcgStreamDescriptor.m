#import "LcgStreamDescriptor.h"
#import "LcgStreamCipher.h"
#import "LcgStreamVectors.h"

@implementation LcgStreamDescriptor

- (NSString *)family {
    return @"lcgstream";
}

- (NSString *)suite {
    return @"stream";
}

- (id<CLCipher>)cipher {
    return [[LcgStreamCipher alloc] init];
}

- (NSArray *)vectors {
    return [LcgStreamVectors all];
}

@end
