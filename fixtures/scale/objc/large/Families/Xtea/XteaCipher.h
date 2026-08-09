#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "xtea" family; registered with
// the rest of the suite via XteaDescriptor.
@interface XteaCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger rounds;

@end
