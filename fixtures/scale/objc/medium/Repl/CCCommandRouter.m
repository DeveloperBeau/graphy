#import "CCCommandRouter.h"

@implementation CCCommandRouter

+ (NSString *)dispatch:(NSString *)line context:(CCReplContext *)context {
    NSString *trimmed = [line stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]];
    if ([trimmed isEqualToString:@"help"]) {
        return [@"functions: " stringByAppendingString:[context.functions.names componentsJoinedByString:@", "]];
    }
    if ([trimmed isEqualToString:@"history"]) {
        return [NSString stringWithFormat:@"%lu entries logged", (unsigned long)[context.history count]];
    }
    if ([trimmed isEqualToString:@"quit"]) {
        context.settings.running = NO;
        return @"bye";
    }
    return [@"unknown command :" stringByAppendingString:trimmed];
}

@end
