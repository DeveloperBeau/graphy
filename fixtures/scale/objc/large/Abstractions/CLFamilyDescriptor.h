#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Metadata plus factory methods for one cipher family; every family
// under Families/ provides exactly one conforming class.
@protocol CLFamilyDescriptor <NSObject>

- (NSString *)family;
- (NSString *)suite;
- (id<CLCipher>)cipher;
- (NSArray *)vectors;

@end
