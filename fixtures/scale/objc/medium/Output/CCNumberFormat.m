#import "CCNumberFormat.h"

@implementation CCNumberFormat

+ (NSString *)format:(double)value precision:(NSInteger)precision {
    NSString *spec = [NSString stringWithFormat:@"%%.%ldf", (long)precision];
    return [NSString stringWithFormat:spec, value];
}

@end
