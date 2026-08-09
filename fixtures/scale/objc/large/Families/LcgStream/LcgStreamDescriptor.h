#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together LcgStreamCipher
// and LcgStreamVectors under the "stream" suite so CLHarness and the
// report classes never need to know about LcgStreamCipher directly.
// See LcgStreamDescriptor.m for the three protocol method bodies.
@interface LcgStreamDescriptor : NSObject <CLFamilyDescriptor>

@end
