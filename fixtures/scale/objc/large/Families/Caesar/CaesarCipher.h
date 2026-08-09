#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "caesar" family; registered with
// the rest of the suite via CaesarDescriptor.
@interface CaesarCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
