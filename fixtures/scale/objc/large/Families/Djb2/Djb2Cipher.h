#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "djb2" family; registered with
// the rest of the suite via Djb2Descriptor.
@interface Djb2Cipher : NSObject <CLCipher>

@property (nonatomic, assign) uint32_t seed;
@property (nonatomic, assign) uint32_t prime;

@end
