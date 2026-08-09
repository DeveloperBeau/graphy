#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "columnar" family; registered with
// the rest of the suite via ColumnarDescriptor.
@interface ColumnarCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
