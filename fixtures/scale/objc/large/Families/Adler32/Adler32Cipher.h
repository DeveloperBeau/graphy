#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "adler32" family; registered with
// the rest of the suite via Adler32Descriptor.
@interface Adler32Cipher : NSObject <CLCipher>

@property (nonatomic, assign) uint32_t seed;
@property (nonatomic, assign) uint32_t prime;

@end
