#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together Rc4Cipher
// and Rc4Vectors under the "stream" suite so CLHarness and the
// report classes never need to know about Rc4Cipher directly.
// See Rc4Descriptor.m for the three protocol method bodies.
@interface Rc4Descriptor : NSObject <CLFamilyDescriptor>

@end
