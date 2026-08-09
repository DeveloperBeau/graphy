#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "railfence" family; registered with
// the rest of the suite via RailfenceDescriptor.
@interface RailfenceCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
