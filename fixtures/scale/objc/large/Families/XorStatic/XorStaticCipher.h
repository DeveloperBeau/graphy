#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "xorstatic" family; registered with
// the rest of the suite via XorStaticDescriptor.
@interface XorStaticCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger mask;

@end
