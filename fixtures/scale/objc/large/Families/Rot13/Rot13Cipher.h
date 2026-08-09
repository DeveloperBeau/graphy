#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "rot13" family; registered with
// the rest of the suite via Rot13Descriptor.
@interface Rot13Cipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
