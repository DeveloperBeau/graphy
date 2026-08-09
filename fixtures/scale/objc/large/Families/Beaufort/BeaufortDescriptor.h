#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together BeaufortCipher
// and BeaufortVectors under the "polyalphabetic" suite so CLHarness and the
// report classes never need to know about BeaufortCipher directly.
// See BeaufortDescriptor.m for the three protocol method bodies.
@interface BeaufortDescriptor : NSObject <CLFamilyDescriptor>

@end
