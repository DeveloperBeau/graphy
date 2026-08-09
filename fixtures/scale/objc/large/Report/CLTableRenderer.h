#import <Foundation/Foundation.h>

// Minimal two-space-delimited table renderer shared by both report
// classes; deliberately dumber than CCTablePrinter in the calc fixture.
@interface CLTableRenderer : NSObject

- (void)addRow:(NSArray<NSString *> *)cells;
- (NSString *)render;

@end
