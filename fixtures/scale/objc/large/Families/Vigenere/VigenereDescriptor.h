#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together VigenereCipher
// and VigenereVectors under the "polyalphabetic" suite so CLHarness and the
// report classes never need to know about VigenereCipher directly.
// See VigenereDescriptor.m for the three protocol method bodies.
@interface VigenereDescriptor : NSObject <CLFamilyDescriptor>

@end
