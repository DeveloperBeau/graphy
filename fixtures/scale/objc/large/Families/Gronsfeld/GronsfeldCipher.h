#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "gronsfeld" family; registered with
// the rest of the suite via GronsfeldDescriptor.
@interface GronsfeldCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
