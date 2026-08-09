#import <Foundation/Foundation.h>

@interface CCSettings : NSObject

@property (nonatomic, assign) NSInteger precision;
@property (nonatomic, assign) BOOL running;

+ (instancetype)interactive;

@end
