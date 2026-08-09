#import <Foundation/Foundation.h>
#import "TPOptions.h"

@interface TPRenderer : NSObject

- (instancetype)initWithOptions:(TPOptions *)options;

// Wraps, aligns and (optionally) frames text per the given options.
- (NSString *)render:(NSString *)text;

@end
