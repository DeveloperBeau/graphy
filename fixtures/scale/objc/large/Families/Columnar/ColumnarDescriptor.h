#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// Registered once in CLFamilyCatalog; ties together ColumnarCipher
// and ColumnarVectors under the "transposition" suite so CLHarness and the
// report classes never need to know about ColumnarCipher directly.
// See ColumnarDescriptor.m for the three protocol method bodies.
@interface ColumnarDescriptor : NSObject <CLFamilyDescriptor>

@end
