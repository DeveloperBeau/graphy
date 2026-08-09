#import "ScytaleDescriptor.h"
#import "ScytaleCipher.h"
#import "ScytaleVectors.h"

@implementation ScytaleDescriptor

- (NSString *)family {
    return @"scytale";
}

- (NSString *)suite {
    return @"transposition";
}

- (id<CLCipher>)cipher {
    return [[ScytaleCipher alloc] init];
}

- (NSArray *)vectors {
    return [ScytaleVectors all];
}

@end
