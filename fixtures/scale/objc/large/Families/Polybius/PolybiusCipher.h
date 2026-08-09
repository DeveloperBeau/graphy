#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "polybius" family; registered with
// the rest of the suite via PolybiusDescriptor.
@interface PolybiusCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
