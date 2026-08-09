#import <Foundation/Foundation.h>

@interface CCNumberFormat : NSObject

// Fixed-point formatting shared by CCRepl and the :vars/:history commands.
// precision is clamped by the caller; this class trusts its input
// and never raises on NaN or infinite values.
+ (NSString *)format:(double)value precision:(NSInteger)precision;

@end
