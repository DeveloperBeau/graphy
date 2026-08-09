#import <Foundation/Foundation.h>

// Result of running one family's test vectors through CLCorrectnessEngine.
@interface CLVectorOutcome : NSObject

@property (nonatomic, copy) NSString *family;
@property (nonatomic, assign) BOOL passed;
@property (nonatomic, copy) NSString *detail;

+ (instancetype)outcomeWithFamily:(NSString *)family passed:(BOOL)passed detail:(NSString *)detail;

@end
