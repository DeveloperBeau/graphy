#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "fnv1a32" family; registered with
// the rest of the suite via Fnv1a32Descriptor.
@interface Fnv1a32Cipher : NSObject <CLCipher>

@property (nonatomic, assign) uint32_t seed;
@property (nonatomic, assign) uint32_t prime;

@end
