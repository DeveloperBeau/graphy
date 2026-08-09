#import <Foundation/Foundation.h>

// Buckets CLFamilyCatalog's descriptors by suite (classical, stream,
// block, hash, ...) for the per-suite section of the CLI report.
@interface CLSuiteMap : NSObject

+ (NSDictionary *)grouped;
+ (NSArray *)suiteNames;

@end
