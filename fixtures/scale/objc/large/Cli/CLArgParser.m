#import "CLArgParser.h"

@implementation CLArgParser

+ (instancetype)parse:(NSArray<NSString *> *)args {
    CLArgParser *config = [[CLArgParser alloc] init];
    config.iterations = 2000;
    config.suiteFilter = @"all";
    config.persist = YES;
    for (NSUInteger i = 0; i < args.count; i++) {
        if ([args[i] isEqualToString:@"--iterations"] && i + 1 < args.count) {
            config.iterations = [args[++i] integerValue];
        } else if ([args[i] isEqualToString:@"--suite"] && i + 1 < args.count) {
            config.suiteFilter = args[++i];
        } else if ([args[i] isEqualToString:@"--no-persist"]) {
            config.persist = NO;
        }
    }
    return config;
}

@end
