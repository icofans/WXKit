//
//  NSTimer+Category.m
//  WXKit
//
//  Created by 张鹏 on 2018/2/17.
//  Copyright © 2018年 zhangpeng. All rights reserved.
//

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#endif
#import "NSMutableAttributedString+WXAttribute.h"

@implementation NSMutableAttributedString (WXAttribute)

- (void)safelyAddAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range
{
    if ([self isNilOrNullObject:attrs]) {
        return;
    }
    if ([self isCorrectRange:range forMutableAttributedString:self]) {
        [self addAttributes:attrs range:range];
    }
}

- (BOOL)isNilOrNullObject:(id)object
{
    if (object == nil || [object isEqual: [NSNull null]]) {
        NSLog(@"function : %s has invalid argument : object can't be nil" , __FUNCTION__);
        return YES;
    }
    return NO;
}

- (BOOL)isCorrectRange:(NSRange)range forMutableAttributedString:(NSMutableAttributedString *)mutableAttributedString
{
    if (range.location + range.length <= mutableAttributedString.string.length) {
        return YES;
    }
    return NO;
}

- (void)addLineWithStyle:(WXLineStyle)lineStyle range:(NSRange)range
{
    switch (lineStyle) {
        case WXLineStyleDelete:
        {
            [self safelyAddAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}
                                range: NSMakeRange(0, self.string.length)];
            
            [self safelyAddAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                        NSBaselineOffsetAttributeName : @0}
                                range:range];
            break;
        }
        case WXLineStyleUnder:
        {
            [self safelyAddAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}
                                range: NSMakeRange(0, self.string.length)];
            
            [self safelyAddAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}
                                range:range];
            break;
        }
        default:
            break;
    }
}

@end
