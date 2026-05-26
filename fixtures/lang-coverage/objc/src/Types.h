// feature: protocol, enum typedef
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ServiceState) {
    ServiceStateIdle,
    ServiceStateRunning,
    ServiceStateDone,
};

@protocol Greet <NSObject>
- (NSString *)greeting;
+ (id)shared;
@end
