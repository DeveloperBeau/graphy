#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "blockreverse" family; registered with
// the rest of the suite via BlockReverseDescriptor.
@interface BlockReverseCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger rounds;

@end
