#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together RotByteCipher
// and RotByteVectors under the "stream" suite so CLHarness and the
// report classes never need to know about RotByteCipher directly.
// See RotByteDescriptor.m for the three protocol method bodies.
@interface RotByteDescriptor : NSObject <CLFamilyDescriptor>

@end
