#import "KeywordDescriptor.h"
#import "KeywordCipher.h"
#import "KeywordVectors.h"

@implementation KeywordDescriptor

- (NSString *)family {
    return @"keyword";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[KeywordCipher alloc] init];
}

- (NSArray *)vectors {
    return [KeywordVectors all];
}

@end
