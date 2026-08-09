#import <Foundation/Foundation.h>
#import "CLCipher.h"

// Concrete implementation for the "vigenere" family; registered with
// the rest of the suite via VigenereDescriptor.
@interface VigenereCipher : NSObject <CLCipher>

@property (nonatomic, assign) NSInteger shift;
@property (nonatomic, assign) NSInteger step;

@end
