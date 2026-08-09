#import <Foundation/Foundation.h>

@interface TPWrapper : NSObject

// Greedily fills lines up to width, breaking on spaces only.
// Used by TPRenderer before alignment and border framing.
// Never splits a single word even if it exceeds width.
+ (NSArray<NSString *> *)wrap:(NSString *)text width:(NSInteger)width;

@end
