#import "AffineVectors.h"
#import "CLTestVector.h"

@implementation AffineVectors

+ (NSArray *)all {
    NSMutableArray *vectors = [NSMutableArray array];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"ATTACKATDAWN" expected:@"GABJMVMGRPME"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"THEQUICKBROWNFOX" expected:@"ZOMZETOXPGENFYIS"]];
        [vectors addObject:[CLTestVector vectorWithPlaintext:@"DEFENDTHEEASTWALL" expected:@"JLNNXOFUSTQJLPUGH"]];
    return vectors;
}

@end
