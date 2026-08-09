#import <Foundation/Foundation.h>

@interface TPOptions : NSObject

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, copy) NSString *align;
@property (nonatomic, copy) NSString *borderStyle;

+ (instancetype)defaults;

@end
