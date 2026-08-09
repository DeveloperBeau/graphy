#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "bacon" family; registered with
// the rest of the suite via BaconDescriptor.
@interface BaconCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
