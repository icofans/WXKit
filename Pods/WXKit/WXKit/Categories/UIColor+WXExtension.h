//
//  UIColor+WXExtension.h
//  Pods-WXKit_Example
//
//  Created by 王家强 on 2018/1/31.
//

#import <UIKit/UIKit.h>

@interface UIColor (WXExtension)

/**
 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
 
 @param color 十六进制的颜色值
 @return color
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
