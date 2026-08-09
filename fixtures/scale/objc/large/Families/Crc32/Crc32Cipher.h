#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "crc32" family; registered with
// the rest of the suite via Crc32Descriptor.
@interface Crc32Cipher : NSObject <CLCipher>

@property (nonatomic, assign) uint32_t seed;
@property (nonatomic, assign) uint32_t prime;

@end
