#import <Foundation/Foundation.h>
#import "CCEnvironment.h"
#import "CCFunctionRegistry.h"
#import "CCHistoryLog.h"
#import "CCSettings.h"

@interface CCReplContext : NSObject

@property (nonatomic, strong) CCEnvironment *environment;
@property (nonatomic, strong) CCFunctionRegistry *functions;
@property (nonatomic, strong) CCHistoryLog *history;
@property (nonatomic, strong) CCSettings *settings;

- (instancetype)initWithSettings:(CCSettings *)settings;

@end
