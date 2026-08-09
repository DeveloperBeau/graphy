#import "CCPrecedence.h"

@implementation CCPrecedence

+ (NSInteger)of:(NSString *)op {
    if ([op isEqualToString:@"+"] || [op isEqualToString:@"-"]) return 1;
    if ([op isEqualToString:@"*"] || [op isEqualToString:@"/"]) return 2;
    if ([op isEqualToString:@"^"]) return 3;
    return 0;
}

@end
