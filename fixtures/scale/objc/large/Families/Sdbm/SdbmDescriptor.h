#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together SdbmCipher
// and SdbmVectors under the "hash" suite so CLHarness and the
// report classes never need to know about SdbmCipher directly.
// See SdbmDescriptor.m for the three protocol method bodies.
@interface SdbmDescriptor : NSObject <CLFamilyDescriptor>

@end
