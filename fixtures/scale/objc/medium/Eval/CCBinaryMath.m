#import "CCBinaryMath.h"

@implementation CCBinaryMath

+ (double)apply:(NSString *)op left:(double)left right:(double)right {
    if ([op isEqualToString:@"+"]) return left + right;
    if ([op isEqualToString:@"-"]) return left - right;
    if ([op isEqualToString:@"*"]) return left * right;
    if ([op isEqualToString:@"/"]) return right == 0 ? 0 : left / right;
    return pow(left, right);
}

@end
