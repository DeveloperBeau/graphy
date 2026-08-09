#import "SubstitutionDescriptor.h"
#import "SubstitutionCipher.h"
#import "SubstitutionVectors.h"

@implementation SubstitutionDescriptor

- (NSString *)family {
    return @"substitution";
}

- (NSString *)suite {
    return @"classical";
}

- (id<CLCipher>)cipher {
    return [[SubstitutionCipher alloc] init];
}

- (NSArray *)vectors {
    return [SubstitutionVectors all];
}

@end
