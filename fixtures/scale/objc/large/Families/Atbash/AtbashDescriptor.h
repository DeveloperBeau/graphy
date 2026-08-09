#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together AtbashCipher
// and AtbashVectors under the "classical" suite so CLHarness and the
// report classes never need to know about AtbashCipher directly.
// See AtbashDescriptor.m for the three protocol method bodies.
@interface AtbashDescriptor : NSObject <CLFamilyDescriptor>

@end
