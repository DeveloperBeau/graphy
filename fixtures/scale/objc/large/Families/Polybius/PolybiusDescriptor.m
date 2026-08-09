#import "PolybiusDescriptor.h"
#import "PolybiusCipher.h"
#import "PolybiusVectors.h"

@implementation PolybiusDescriptor

- (NSString *)family {
    return @"polybius";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[PolybiusCipher alloc] init];
}

- (NSArray *)vectors {
    return [PolybiusVectors all];
}

@end
