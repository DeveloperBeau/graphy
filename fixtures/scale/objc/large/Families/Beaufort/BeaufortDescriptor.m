#import "BeaufortDescriptor.h"
#import "BeaufortCipher.h"
#import "BeaufortVectors.h"

@implementation BeaufortDescriptor

- (NSString *)family {
    return @"beaufort";
}

- (NSString *)suite {
    return @"polyalphabetic";
}

- (id<CLCipher>)cipher {
    return [[BeaufortCipher alloc] init];
}

- (NSArray *)vectors {
    return [BeaufortVectors all];
}

@end
