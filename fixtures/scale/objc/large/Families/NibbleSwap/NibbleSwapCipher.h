#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "nibbleswap" family; registered with
// the rest of the suite via NibbleSwapDescriptor.
@interface NibbleSwapCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger mask;

@end
