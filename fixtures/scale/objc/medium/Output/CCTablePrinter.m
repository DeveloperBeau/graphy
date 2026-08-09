#import "CCTablePrinter.h"

@interface CCTablePrinter ()
@property (nonatomic, strong) NSArray<NSString *> *headers;
@property (nonatomic, strong) NSMutableArray<NSArray<NSString *> *> *rows;
@end

@implementation CCTablePrinter

- (instancetype)initWithHeaders:(NSArray<NSString *> *)headers {
    if ((self = [super init])) {
        _headers = headers;
        _rows = [NSMutableArray array];
    }
    return self;
}

- (void)addRow:(NSArray<NSString *> *)cells {
    [self.rows addObject:cells];
}

- (NSString *)render {
    NSMutableArray<NSString *> *lines = [NSMutableArray arrayWithObject:[self.headers componentsJoinedByString:@" | "]];
    for (NSArray<NSString *> *row in self.rows) {
        [lines addObject:[row componentsJoinedByString:@" | "]];
    }
    return [lines componentsJoinedByString:@"\n"];
}

@end
