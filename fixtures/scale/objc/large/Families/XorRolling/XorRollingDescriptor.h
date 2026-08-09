#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together XorRollingCipher
// and XorRollingVectors under the "stream" suite so CLHarness and the
// report classes never need to know about XorRollingCipher directly.
// See XorRollingDescriptor.m for the three protocol method bodies.
@interface XorRollingDescriptor : NSObject <CLFamilyDescriptor>

@end
