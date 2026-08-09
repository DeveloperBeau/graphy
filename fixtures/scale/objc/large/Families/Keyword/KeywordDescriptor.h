#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together KeywordCipher
// and KeywordVectors under the "classical" suite so CLHarness and the
// report classes never need to know about KeywordCipher directly.
// See KeywordDescriptor.m for the three protocol method bodies.
@interface KeywordDescriptor : NSObject <CLFamilyDescriptor>

@end
