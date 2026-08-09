#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together TeaCipher
// and TeaVectors under the "block" suite so CLHarness and the
// report classes never need to know about TeaCipher directly.
// See TeaDescriptor.m for the three protocol method bodies.
@interface TeaDescriptor : NSObject <CLFamilyDescriptor>

@end
