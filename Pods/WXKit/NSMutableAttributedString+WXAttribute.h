//
//  NSMutableAttributedString+AddAttributeStyle.h
//  WXKit
//
//  Created by zhangpeng on 2018/2/11.
//  Copyright © 2018年 zhangpeng. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WXLineStyle) {
    WXLineStyleDelete,
    WXLineStyleUnder
};

@interface NSMutableAttributedString (WXAttribute)

- (void)safelyAddAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range;

- (void)addLineWithStyle:(WXLineStyle)lineStyle range:(NSRange)range;

@end
