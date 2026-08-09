#import "TPBorder.h"

@interface TPBorder ()
@property (nonatomic, copy) NSString *horizontal;
@end

@implementation TPBorder

- (instancetype)initWithStyle:(NSString *)style {
    if ((self = [super init])) {
        _horizontal = [style isEqualToString:@"double"] ? @"=" : @"-";
    }
    return self;
}

- (NSArray<NSString *> *)frame:(NSArray<NSString *> *)lines width:(NSInteger)width {
    NSString *rule = [NSString stringWithFormat:@"+%@+",
        [@"" stringByPaddingToLength:width + 2 withString:self.horizontal startingAtIndex:0]];
    NSMutableArray<NSString *> *framed = [NSMutableArray arrayWithObject:rule];
    for (NSString *line in lines) {
        [framed addObject:[NSString stringWithFormat:@"| %@ |", line]];
    }
    [framed addObject:rule];
    return framed;
}

@end
