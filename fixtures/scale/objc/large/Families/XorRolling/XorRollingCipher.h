#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "xorrolling" family; registered with
// the rest of the suite via XorRollingDescriptor.
@interface XorRollingCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger mask;

@end
