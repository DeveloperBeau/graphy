#import "CLStorePaths.h"

@implementation CLStorePaths

+ (NSString *)storeDir {
    return [[[NSFileManager defaultManager] currentDirectoryPath] stringByAppendingPathComponent:@".cipherlab"];
}

+ (NSString *)resultsFile {
    return [[self storeDir] stringByAppendingPathComponent:@"results.jsonl"];
}

@end
