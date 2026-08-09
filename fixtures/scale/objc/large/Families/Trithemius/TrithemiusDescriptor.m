#import "TrithemiusDescriptor.h"
#import "TrithemiusCipher.h"
#import "TrithemiusVectors.h"

@implementation TrithemiusDescriptor

- (NSString *)family {
    return @"trithemius";
}

- (NSString *)suite {
    return @"polyalphabetic";
}

- (id<CLCipher>)cipher {
    return [[TrithemiusCipher alloc] init];
}

- (NSArray *)vectors {
    return [TrithemiusVectors all];
}

@end
