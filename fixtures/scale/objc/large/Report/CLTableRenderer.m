#import "CLTableRenderer.h"

@interface CLTableRenderer ()
@property (nonatomic, strong) NSMutableArray *rows;
@end

@implementation CLTableRenderer

- (instancetype)init {
    if ((self = [super init])) { _rows = [NSMutableArray array]; }
    return self;
}

- (void)addRow:(NSArray<NSString *> *)cells {
    [self.rows addObject:cells];
}

- (NSString *)render {
    NSMutableArray *lines = [NSMutableArray array];
    for (NSArray<NSString *> *row in self.rows) {
        [lines addObject:[row componentsJoinedByString:@"  "]];
    }
    return [lines componentsJoinedByString:@"\n"];
}

@end
