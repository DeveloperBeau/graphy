// feature: @interface with inheritance, protocol conformance, property
#import <Foundation/Foundation.h>
#import "Types.h"
#import "Helpers.h"

@interface Service : NSObject <Greet>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) ServiceState state;
- (instancetype)initWithName:(NSString *)name;
- (void)run;
- (NSString *)greeting;
+ (id)shared;
@end
