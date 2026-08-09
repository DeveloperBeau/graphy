#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "scytale" family; registered with
// the rest of the suite via ScytaleDescriptor.
@interface ScytaleCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
