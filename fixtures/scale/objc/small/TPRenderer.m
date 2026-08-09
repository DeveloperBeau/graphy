#import "TPRenderer.h"
#import "TPWrapper.h"
#import "TPAlignment.h"
#import "TPBorder.h"

@interface TPRenderer ()
@property (nonatomic, strong) TPOptions *options;
@end

@implementation TPRenderer

- (instancetype)initWithOptions:(TPOptions *)options {
    if ((self = [super init])) {
        _options = options;
    }
    return self;
}

- (NSString *)render:(NSString *)text {
    NSArray<NSString *> *lines = [TPWrapper wrap:text width:self.options.width];
    NSMutableArray<NSString *> *aligned = [NSMutableArray array];
    for (NSString *line in lines) {
        [aligned addObject:[TPAlignment alignLine:line width:self.options.width mode:self.options.align]];
    }
    TPBorder *border = [[TPBorder alloc] initWithStyle:self.options.borderStyle];
    return [[border frame:aligned width:self.options.width] componentsJoinedByString:@"\n"];
}

@end
