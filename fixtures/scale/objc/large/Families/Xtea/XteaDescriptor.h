#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together XteaCipher
// and XteaVectors under the "block" suite so CLHarness and the
// report classes never need to know about XteaCipher directly.
// See XteaDescriptor.m for the three protocol method bodies.
@interface XteaDescriptor : NSObject <CLFamilyDescriptor>

@end
