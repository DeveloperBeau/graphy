#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together Djb2Cipher
// and Djb2Vectors under the "hash" suite so CLHarness and the
// report classes never need to know about Djb2Cipher directly.
// See Djb2Descriptor.m for the three protocol method bodies.
@interface Djb2Descriptor : NSObject <CLFamilyDescriptor>

@end
