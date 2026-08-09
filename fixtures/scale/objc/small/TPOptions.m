#import "TPOptions.h"

@implementation TPOptions

+ (instancetype)defaults {
    TPOptions *options = [[TPOptions alloc] init];
    options.width = 60;
    options.align = @"left";
    options.borderStyle = @"single";
    return options;
}

@end
