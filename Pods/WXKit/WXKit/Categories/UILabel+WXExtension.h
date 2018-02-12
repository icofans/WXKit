//
//  UILabel+WXExtension.h
//  Pods-WXKit_Example
//
//  Created by 王家强 on 2018/1/31.
//

#import <UIKit/UIKit.h>

@interface UILabel (WXExtension)

/**
 控制字体与控件边界的间隙
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;

/**
 获取单行文字以数组形式返回
 
 @param text 文本
 @param maxWidth 最大Width
 @param font 字体
 */
- (NSArray *)lineText:(NSString *)text
             maxWidth:(CGFloat)maxWidth
                 font:(UIFont *)font;

/**
 获取单行文字以数组形式返回
 */
- (NSArray *)lineText:(NSString *)text;

@end
