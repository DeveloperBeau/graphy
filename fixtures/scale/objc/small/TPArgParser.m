#import "TPArgParser.h"

@implementation TPArgParser

+ (TPOptions *)parse:(NSArray<NSString *> *)args {
    TPOptions *options = [TPOptions defaults];
    for (NSUInteger i = 0; i < args.count; i++) {
        NSString *arg = args[i];
        if ([arg isEqualToString:@"--width"] && i + 1 < args.count) {
            options.width = [args[++i] integerValue];
        } else if ([arg isEqualToString:@"--align"] && i + 1 < args.count) {
            options.align = args[++i];
        } else if ([arg isEqualToString:@"--border"] && i + 1 < args.count) {
            options.borderStyle = args[++i];
        }
    }
    return options;
}

@end
