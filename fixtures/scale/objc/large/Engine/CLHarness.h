#import <Foundation/Foundation.h>

// Top-level correctness pass: walks CLFamilyCatalog, verifies each
// family, and prints live progress to stderr as it goes so a long
// run never looks stuck.
@interface CLHarness : NSObject

- (NSArray *)runAll;

@end
