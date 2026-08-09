#import <Foundation/Foundation.h>

@interface CLArgParser : NSObject

@property (nonatomic, assign) NSInteger iterations;
@property (nonatomic, copy) NSString *suiteFilter;
@property (nonatomic, assign) BOOL persist;

+ (instancetype)parse:(NSArray<NSString *> *)args;

@end
