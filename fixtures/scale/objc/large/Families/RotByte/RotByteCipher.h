#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "rotbyte" family; registered with
// the rest of the suite via RotByteDescriptor.
@interface RotByteCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger mask;

@end
