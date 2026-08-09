#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "atbash" family; registered with
// the rest of the suite via AtbashDescriptor.
@interface AtbashCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
