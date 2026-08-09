#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together Crc32Cipher
// and Crc32Vectors under the "hash" suite so CLHarness and the
// report classes never need to know about Crc32Cipher directly.
// See Crc32Descriptor.m for the three protocol method bodies.
@interface Crc32Descriptor : NSObject <CLFamilyDescriptor>

@end
