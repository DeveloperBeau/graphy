#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together ScytaleCipher
// and ScytaleVectors under the "transposition" suite so CLHarness and the
// report classes never need to know about ScytaleCipher directly.
// See ScytaleDescriptor.m for the three protocol method bodies.
@interface ScytaleDescriptor : NSObject <CLFamilyDescriptor>

@end
