#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together SubstitutionCipher
// and SubstitutionVectors under the "classical" suite so CLHarness and the
// report classes never need to know about SubstitutionCipher directly.
// See SubstitutionDescriptor.m for the three protocol method bodies.
@interface SubstitutionDescriptor : NSObject <CLFamilyDescriptor>

@end
