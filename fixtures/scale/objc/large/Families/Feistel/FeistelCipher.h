#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "feistel" family; registered with
// the rest of the suite via FeistelDescriptor.
@interface FeistelCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger rounds;

@end
