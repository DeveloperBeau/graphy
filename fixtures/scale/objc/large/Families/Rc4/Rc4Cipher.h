#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "rc4" family; registered with
// the rest of the suite via Rc4Descriptor.
@interface Rc4Cipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger mask;

@end
