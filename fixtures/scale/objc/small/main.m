#import <Foundation/Foundation.h>
#import "TPArgParser.h"
#import "TPRenderer.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        NSMutableArray<NSString *> *args = [NSMutableArray array];
        for (int i = 1; i < argc; i++) {
            [args addObject:[NSString stringWithUTF8String:argv[i]]];
        }
        TPOptions *options = [TPArgParser parse:args];
        TPRenderer *renderer = [[TPRenderer alloc] initWithOptions:options];
        NSLog(@"%@", [renderer render:@"a small text printer demo for testing wrap and borders"]);
    }
    return 0;
}
