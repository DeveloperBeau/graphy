#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "tea" family; registered with
// the rest of the suite via TeaDescriptor.
@interface TeaCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger rounds;

@end
