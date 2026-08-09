#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "sdbm" family; registered with
// the rest of the suite via SdbmDescriptor.
@interface SdbmCipher : NSObject <CLCipher>

@property (nonatomic, assign) uint32_t seed;
@property (nonatomic, assign) uint32_t prime;

@end
