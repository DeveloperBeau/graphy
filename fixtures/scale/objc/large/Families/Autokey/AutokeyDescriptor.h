#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together AutokeyCipher
// and AutokeyVectors under the "polyalphabetic" suite so CLHarness and the
// report classes never need to know about AutokeyCipher directly.
// See AutokeyDescriptor.m for the three protocol method bodies.
@interface AutokeyDescriptor : NSObject <CLFamilyDescriptor>

@end
