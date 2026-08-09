#import "AtbashVectors.h"
#import "CLTestVector.h"

@implementation AtbashVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"FBEOTEXTGGFZ"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"YPPELCZKEXXICXJV"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"IMQSEXQHHKJEIOVJM"]];
    return vectors;
}

@end
