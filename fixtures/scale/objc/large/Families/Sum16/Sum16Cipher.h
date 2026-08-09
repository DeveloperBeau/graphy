#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "sum16" family; registered with
// the rest of the suite via Sum16Descriptor.
@interface Sum16Cipher : NSObject <CLCipher>

@property (nonatomic, assign) uint32_t seed;
@property (nonatomic, assign) uint32_t prime;

@end
