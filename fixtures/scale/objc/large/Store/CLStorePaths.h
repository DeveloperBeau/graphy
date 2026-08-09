#import <Foundation/Foundation.h>

// Filesystem locations shared by CLResultsStore; kept apart so the
// on-disk layout can change without touching read/write logic.
@interface CLStorePaths : NSObject

+ (NSString *)storeDir;
+ (NSString *)resultsFile;

@end
