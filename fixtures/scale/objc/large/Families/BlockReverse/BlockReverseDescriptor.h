#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together BlockReverseCipher
// and BlockReverseVectors under the "block" suite so CLHarness and the
// report classes never need to know about BlockReverseCipher directly.
// See BlockReverseDescriptor.m for the three protocol method bodies.
@interface BlockReverseDescriptor : NSObject <CLFamilyDescriptor>

@end
