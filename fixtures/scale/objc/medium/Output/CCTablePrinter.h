#import <Foundation/Foundation.h>

// Minimal pipe-delimited table renderer used by the :vars and
// :history REPL commands to line up columns.
@interface CCTablePrinter : NSObject

- (instancetype)initWithHeaders:(NSArray<NSString *> *)headers;
- (void)addRow:(NSArray<NSString *> *)cells;
- (NSString *)render;

@end
