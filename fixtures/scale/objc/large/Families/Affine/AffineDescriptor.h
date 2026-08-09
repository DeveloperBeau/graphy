#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together AffineCipher
// and AffineVectors under the "classical" suite so CLHarness and the
// report classes never need to know about AffineCipher directly.
// See AffineDescriptor.m for the three protocol method bodies.
@interface AffineDescriptor : NSObject <CLFamilyDescriptor>

@end
