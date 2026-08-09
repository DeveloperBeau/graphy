#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "keyword" family; registered with
// the rest of the suite via KeywordDescriptor.
@interface KeywordCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
