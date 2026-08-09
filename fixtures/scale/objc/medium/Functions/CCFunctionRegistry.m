#import "CCFunctionRegistry.h"

@interface CCFunctionRegistry ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, CCBuiltin> *table;
@end

@implementation CCFunctionRegistry

- (instancetype)init {
    if ((self = [super init])) {
        _table = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)define:(NSString *)name body:(CCBuiltin)body {
    self.table[name] = body;
}

- (double)invoke:(NSString *)name arguments:(NSArray<NSNumber *> *)arguments {
    CCBuiltin body = self.table[name];
    return body ? body(arguments) : 0;
}

- (NSArray<NSString *> *)names {
    return [self.table.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

@end
