#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together GronsfeldCipher
// and GronsfeldVectors under the "polyalphabetic" suite so CLHarness and the
// report classes never need to know about GronsfeldCipher directly.
// See GronsfeldDescriptor.m for the three protocol method bodies.
@interface GronsfeldDescriptor : NSObject <CLFamilyDescriptor>

@end
