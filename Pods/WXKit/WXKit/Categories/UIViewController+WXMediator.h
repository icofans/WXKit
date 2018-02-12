//
//  UIViewController+WXMediator.h
//  Pods-WXKit_Example
//
//  Created by 王家强 on 2018/1/31.
//

#import <UIKit/UIKit.h>

@interface NSObject (Parameters)

@property (nonatomic, copy) NSDictionary *mr_parameters;

@end


@interface UIViewController (WXMediator)

/**
 通过类名初始化

 @param className 类名
 @return UIViewController实例
 */
+ (UIViewController *)instantiateViewController:(NSString *)className;


/**
 通过类名初始化 附带参数

 @param className className 类名
 @param parameters 参数
 @return UIViewController实例
 */
+ (UIViewController *)instantiateViewController:(NSString *)className
                                     parameters:(NSDictionary *)parameters;

@end
