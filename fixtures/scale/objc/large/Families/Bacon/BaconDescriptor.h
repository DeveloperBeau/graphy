#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together BaconCipher
// and BaconVectors under the "classical" suite so CLHarness and the
// report classes never need to know about BaconCipher directly.
// See BaconDescriptor.m for the three protocol method bodies.
@interface BaconDescriptor : NSObject <CLFamilyDescriptor>

@end
