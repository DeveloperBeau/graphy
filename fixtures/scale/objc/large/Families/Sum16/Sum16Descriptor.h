#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together Sum16Cipher
// and Sum16Vectors under the "hash" suite so CLHarness and the
// report classes never need to know about Sum16Cipher directly.
// See Sum16Descriptor.m for the three protocol method bodies.
@interface Sum16Descriptor : NSObject <CLFamilyDescriptor>

@end
