#import <Foundation/Foundation.h>

// File-backed run history, persisted between sessions as newline-
// delimited records under CLStorePaths.storeDir.
@interface CLResultsStore : NSObject

- (NSArray *)priorRuns;
- (void)persist:(NSArray *)records;
- (NSInteger)previousSessions;

@end
