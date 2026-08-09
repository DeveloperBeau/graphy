#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together RailfenceCipher
// and RailfenceVectors under the "transposition" suite so CLHarness and the
// report classes never need to know about RailfenceCipher directly.
// See RailfenceDescriptor.m for the three protocol method bodies.
@interface RailfenceDescriptor : NSObject <CLFamilyDescriptor>

@end
