#import <Foundation/Foundation.h>

@interface TPBorder : NSObject

- (instancetype)initWithStyle:(NSString *)style;

// Wraps the given lines with a top/bottom rule and side bars.
- (NSArray<NSString *> *)frame:(NSArray<NSString *> *)lines width:(NSInteger)width;

@end
