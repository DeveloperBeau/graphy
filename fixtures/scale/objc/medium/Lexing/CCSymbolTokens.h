#import <Foundation/Foundation.h>
#import "CCToken.h"

// Maps single-character punctuation to its token kind; kept apart
// from CCLexer so the scanning loop stays focused on cursor state.
@interface CCSymbolTokens : NSObject

+ (CCToken *)tokenFor:(unichar)ch;

@end
