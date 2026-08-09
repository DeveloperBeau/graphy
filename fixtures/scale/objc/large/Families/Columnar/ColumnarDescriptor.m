#import "ColumnarDescriptor.h"
#import "ColumnarCipher.h"
#import "ColumnarVectors.h"

@implementation ColumnarDescriptor

- (NSString *)family {
    return @"columnar";
}

- (NSString *)suite {
    return @"transposition";
}

- (id<CLCipher>)cipher {
    return [[ColumnarCipher alloc] init];
}

- (NSArray *)vectors {
    return [ColumnarVectors all];
}

@end
