#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together Adler32Cipher
// and Adler32Vectors under the "hash" suite so CLHarness and the
// report classes never need to know about Adler32Cipher directly.
// See Adler32Descriptor.m for the three protocol method bodies.
@interface Adler32Descriptor : NSObject <CLFamilyDescriptor>

@end
