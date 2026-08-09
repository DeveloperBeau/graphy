#import <Foundation/Foundation.h>

@interface CLResultRecord : NSObject

@property (nonatomic, copy) NSString *family;
@property (nonatomic, copy) NSString *suite;
@property (nonatomic, assign) BOOL passed;

- (NSString *)toLine;
+ (instancetype)fromLine:(NSString *)line;

@end
