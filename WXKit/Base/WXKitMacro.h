//
//  WXKitMacro.h
//  Pods
//
//  Created by 王家强 on 2018/2/11.
//

#ifndef WXKitMacro_h
#define WXKitMacro_h

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#endif

#import <objc/runtime.h>

/**
 运行时方法交换

 @param _class class
 @param _originSelector 需要交换的方法
 @param _newSelector 交换后的方法
 */
CG_INLINE void wx_hook(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

#endif /* WXKitMacro_h */
