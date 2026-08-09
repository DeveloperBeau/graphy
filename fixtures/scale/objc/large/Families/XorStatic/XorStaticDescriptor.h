#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together XorStaticCipher
// and XorStaticVectors under the "stream" suite so CLHarness and the
// report classes never need to know about XorStaticCipher directly.
// See XorStaticDescriptor.m for the three protocol method bodies.
@interface XorStaticDescriptor : NSObject <CLFamilyDescriptor>

@end
