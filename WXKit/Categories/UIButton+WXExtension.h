//
//  UIButton+WXExtension.h
//  WXKit
//
//  Created by 王家强 on 2018/1/31.
//

#import <UIKit/UIKit.h>

@interface UIButton (WXExtension)


/**
 setBorderColor : 添加不同状态的borderColor

 @param borderColor 边框颜色
 @param state 状态枚举
 */
- (void)setBorderColor:(UIColor *)borderColor
              forState:(UIControlState)state;


/**
 setBorderColor : 添加不同状态的backgroundColor

 @param backgroundColor 背景颜色
 @param state 状态枚举
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
                  forState:(UIControlState)state;


@end
