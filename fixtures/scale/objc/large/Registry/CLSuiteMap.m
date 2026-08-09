#import "CLSuiteMap.h"
#import "CLFamilyCatalog.h"
#import "CLFamilyDescriptor.h"

@implementation CLSuiteMap

+ (NSDictionary *)grouped {
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    for (id<CLFamilyDescriptor> descriptor in [CLFamilyCatalog all]) {
        NSString *suite = [descriptor suite];
        if (map[suite] == nil) { map[suite] = [NSMutableArray array]; }
        [map[suite] addObject:descriptor];
    }
    return map;
}

+ (NSArray *)suiteNames {
    return [[[self grouped] allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

@end
