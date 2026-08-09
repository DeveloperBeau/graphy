#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together TrithemiusCipher
// and TrithemiusVectors under the "polyalphabetic" suite so CLHarness and the
// report classes never need to know about TrithemiusCipher directly.
// See TrithemiusDescriptor.m for the three protocol method bodies.
@interface TrithemiusDescriptor : NSObject <CLFamilyDescriptor>

@end
