#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "affine" family; registered with
// the rest of the suite via AffineDescriptor.
@interface AffineCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
