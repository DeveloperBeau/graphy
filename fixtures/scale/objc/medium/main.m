#import <Foundation/Foundation.h>
#import "CCSettings.h"
#import "CCReplContext.h"
#import "CCRepl.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        CCSettings *settings = [CCSettings interactive];
        CCReplContext *context = [[CCReplContext alloc] initWithSettings:settings];
        CCRepl *repl = [[CCRepl alloc] initWithContext:context];
        [repl runOnce:@"1 + 2 * 3"];
        [repl runOnce:@"x = sqrt(16)"];
        [repl runOnce:@":history"];
    }
    return 0;
}
