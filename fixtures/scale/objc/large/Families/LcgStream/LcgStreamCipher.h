#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "lcgstream" family; registered with
// the rest of the suite via LcgStreamDescriptor.
@interface LcgStreamCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger mask;

@end
