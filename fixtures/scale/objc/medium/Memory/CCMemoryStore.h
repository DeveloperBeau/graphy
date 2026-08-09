#import <Foundation/Foundation.h>

// A single scalar "M" register, mirroring a physical calculator's
// store/recall/clear buttons.
@interface CCMemoryStore : NSObject

- (void)store:(double)value;
- (double)recall;
- (void)clear;

@end
