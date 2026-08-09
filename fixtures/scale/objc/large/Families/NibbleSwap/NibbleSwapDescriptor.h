#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together NibbleSwapCipher
// and NibbleSwapVectors under the "stream" suite so CLHarness and the
// report classes never need to know about NibbleSwapCipher directly.
// See NibbleSwapDescriptor.m for the three protocol method bodies.
@interface NibbleSwapDescriptor : NSObject <CLFamilyDescriptor>

@end
