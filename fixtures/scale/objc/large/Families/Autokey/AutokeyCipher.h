#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "autokey" family; registered with
// the rest of the suite via AutokeyDescriptor.
@interface AutokeyCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
