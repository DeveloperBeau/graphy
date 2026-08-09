#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together CaesarCipher
// and CaesarVectors under the "classical" suite so CLHarness and the
// report classes never need to know about CaesarCipher directly.
// See CaesarDescriptor.m for the three protocol method bodies.
@interface CaesarDescriptor : NSObject <CLFamilyDescriptor>

@end
