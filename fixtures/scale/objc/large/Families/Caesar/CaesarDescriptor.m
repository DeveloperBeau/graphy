#import "CaesarDescriptor.h"
#import "CaesarCipher.h"
#import "CaesarVectors.h"

@implementation CaesarDescriptor

- (NSString *)family {
    return @"caesar";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[CaesarCipher alloc] init];
}

- (NSArray *)vectors {
    return [CaesarVectors all];
}

@end
