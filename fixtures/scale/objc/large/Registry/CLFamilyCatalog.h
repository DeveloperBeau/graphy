#import <Foundation/Foundation.h>
#import "CLFamilyDescriptor.h"

// The single source of truth for "every cipher family this build
// knows about"; every other subsystem discovers families through here.
@interface CLFamilyCatalog : NSObject

+ (NSArray *)all;

@end
