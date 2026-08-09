#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "trithemius" family; registered with
// the rest of the suite via TrithemiusDescriptor.
@interface TrithemiusCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
