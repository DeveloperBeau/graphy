#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "substitution" family; registered with
// the rest of the suite via SubstitutionDescriptor.
@interface SubstitutionCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
