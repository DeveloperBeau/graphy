#import "TPAlignment.h"

@implementation TPAlignment

+ (NSString *)alignLine:(NSString *)line width:(NSInteger)width mode:(NSString *)mode {
    NSInteger slack = width - (NSInteger)line.length;
    if (slack <= 0) {
        return line;
    }
    if ([mode isEqualToString:@"right"]) {
        return [[@"" stringByPaddingToLength:slack withString:@" " startingAtIndex:0] stringByAppendingString:line];
    }
    if ([mode isEqualToString:@"center"]) {
        NSInteger left = slack / 2;
        NSString *pad = [@"" stringByPaddingToLength:left withString:@" " startingAtIndex:0];
        return [[pad stringByAppendingString:line] stringByPaddingToLength:width + pad.length withString:@" " startingAtIndex:0];
    }
    return [line stringByPaddingToLength:width withString:@" " startingAtIndex:0];
}

@end
