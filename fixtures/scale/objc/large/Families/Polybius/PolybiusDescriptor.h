#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together PolybiusCipher
// and PolybiusVectors under the "classical" suite so CLHarness and the
// report classes never need to know about PolybiusCipher directly.
// See PolybiusDescriptor.m for the three protocol method bodies.
@interface PolybiusDescriptor : NSObject <CLFamilyDescriptor>

@end
