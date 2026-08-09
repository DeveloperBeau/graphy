#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together FeistelCipher
// and FeistelVectors under the "block" suite so CLHarness and the
// report classes never need to know about FeistelCipher directly.
// See FeistelDescriptor.m for the three protocol method bodies.
@interface FeistelDescriptor : NSObject <CLFamilyDescriptor>

@end
