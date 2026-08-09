#import "BlockReverseDescriptor.h"
#import "BlockReverseCipher.h"
#import "BlockReverseVectors.h"

@implementation BlockReverseDescriptor

- (NSString *)family {
    return @"blockreverse";
}

- (NSString *)suite {
    return @"block";
}

- (id<CLCipher>)cipher {
    return [[BlockReverseCipher alloc] init];
}

- (NSArray *)vectors {
    return [BlockReverseVectors all];
}

@end
