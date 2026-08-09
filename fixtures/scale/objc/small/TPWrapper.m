#import "TPWrapper.h"

@implementation TPWrapper

+ (NSArray<NSString *> *)wrap:(NSString *)text width:(NSInteger)width {
    NSMutableArray<NSString *> *lines = [NSMutableArray array];
    NSString *current = @"";
    for (NSString *word in [text componentsSeparatedByString:@" "]) {
        if (current.length > 0 && (NSInteger)(current.length + word.length + 1) > width) {
            [lines addObject:current];
            current = word;
        } else {
            current = current.length == 0 ? word : [current stringByAppendingFormat:@" %@", word];
        }
    }
    if (current.length > 0) {
        [lines addObject:current];
    }
    return lines;
}

@end
