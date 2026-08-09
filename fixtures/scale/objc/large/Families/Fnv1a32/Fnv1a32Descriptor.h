#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together Fnv1a32Cipher
// and Fnv1a32Vectors under the "hash" suite so CLHarness and the
// report classes never need to know about Fnv1a32Cipher directly.
// See Fnv1a32Descriptor.m for the three protocol method bodies.
@interface Fnv1a32Descriptor : NSObject <CLFamilyDescriptor>

@end
