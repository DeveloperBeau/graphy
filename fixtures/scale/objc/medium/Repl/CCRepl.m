#import "CCRepl.h"
#import "CCParser.h"
#import "CCEvaluator.h"
#import "CCCommandRouter.h"
#import "CCNumberFormat.h"

@interface CCRepl ()
@property (nonatomic, strong) CCReplContext *context;
@end

@implementation CCRepl

- (instancetype)initWithContext:(CCReplContext *)context {
    if ((self = [super init])) {
        _context = context;
    }
    return self;
}

- (void)runOnce:(NSString *)line {
    if ([line hasPrefix:@":"]) {
        NSLog(@"%@", [CCCommandRouter dispatch:line context:self.context]);
        return;
    }
    CCParser *parser = [[CCParser alloc] initWithSource:line];
    CCEvaluator *evaluator = [[CCEvaluator alloc] initWithEnvironment:self.context.environment
                                                             functions:self.context.functions];
    double value = [evaluator eval:[parser parseStatement]];
    [self.context.history appendExpression:line value:value];
    NSLog(@"= %@", [CCNumberFormat format:value precision:self.context.settings.precision]);
}

@end
