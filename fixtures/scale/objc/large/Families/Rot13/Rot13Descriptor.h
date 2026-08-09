#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together Rot13Cipher
// and Rot13Vectors under the "classical" suite so CLHarness and the
// report classes never need to know about Rot13Cipher directly.
// See Rot13Descriptor.m for the three protocol method bodies.
@interface Rot13Descriptor : NSObject <CLFamilyDescriptor>

@end
