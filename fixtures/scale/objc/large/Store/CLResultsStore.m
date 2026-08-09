#import "CLResultsStore.h"
#import "CLStorePaths.h"
#import "CLResultRecord.h"

@implementation CLResultsStore

- (NSArray *)priorRuns {
    NSString *text = [NSString stringWithContentsOfFile:[CLStorePaths resultsFile]
                                                 encoding:NSUTF8StringEncoding error:nil];
    if (text == nil) { return @[]; }
    NSMutableArray *records = [NSMutableArray array];
    for (NSString *line in [text componentsSeparatedByString:@"\n"]) {
        if (line.length > 0) { [records addObject:[CLResultRecord fromLine:line]]; }
    }
    return records;
}

- (void)persist:(NSArray *)records {
    [[NSFileManager defaultManager] createDirectoryAtPath:[CLStorePaths storeDir]
                               withIntermediateDirectories:YES attributes:nil error:nil];
    NSMutableString *out = [NSMutableString string];
    for (CLResultRecord *record in records) { [out appendFormat:@"%@\n", [record toLine]]; }
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:[CLStorePaths resultsFile]];
    if (handle) {
        [handle seekToEndOfFile];
        [handle writeData:[out dataUsingEncoding:NSUTF8StringEncoding]];
    } else {
        [out writeToFile:[CLStorePaths resultsFile] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

- (NSInteger)previousSessions {
    NSArray *runs = [self priorRuns];
    NSMutableSet *families = [NSMutableSet set];
    for (CLResultRecord *record in runs) { [families addObject:record.family]; }
    return families.count == 0 ? 0 : (NSInteger)runs.count / (NSInteger)families.count;
}

@end
