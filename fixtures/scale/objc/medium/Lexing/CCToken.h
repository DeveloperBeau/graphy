#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CCTokenKind) {
    CCTokenKindNumber,
    CCTokenKindIdentifier,
    CCTokenKindOperator,
    CCTokenKindLeftParen,
    CCTokenKindRightParen,
    CCTokenKindComma,
    CCTokenKindEquals,
    CCTokenKindEnd
};

@interface CCToken : NSObject

@property (nonatomic, assign) CCTokenKind kind;
@property (nonatomic, copy) NSString *text;

+ (instancetype)tokenWithKind:(CCTokenKind)kind text:(NSString *)text;
- (double)numberValue;

@end
