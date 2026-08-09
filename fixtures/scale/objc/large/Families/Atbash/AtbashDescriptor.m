#import "AtbashDescriptor.h"
#import "AtbashCipher.h"
#import "AtbashVectors.h"

@implementation AtbashDescriptor

- (NSString *)family {
    return @"atbash";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[AtbashCipher alloc] init];
}

- (NSArray *)vectors {
    return [AtbashVectors all];
}

@end
