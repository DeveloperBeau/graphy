#import <Foundation/Foundation.h>

@interface TPAlignment : NSObject

// mode is one of "left", "center", "right"; unknown modes behave as left.
// Padding is applied with plain spaces, no ANSI escapes involved.
// Called once per wrapped line, after TPWrapper.wrap:width: runs.
+ (NSString *)alignLine:(NSString *)line width:(NSInteger)width mode:(NSString *)mode;

@end
