//
//  NSArray+WXSafe.m
//  Pods-WXKitDemo
//
//  Created by 王家强 on 2018/2/11.
//

#import "NSArray+WXSafe.h"
#import "WXKitMacro.h"

@implementation NSArray (WXSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSArrayI");
        wx_hook(class, @selector(objectAtIndex:), @selector(wx_objectAtIndex:));
    });
}

- (id)wx_objectAtIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1)) { // 数组越界
        NSAssert(NO, @"数组越界了"); // 只有开发的时候才会造成程序崩了
        return nil;
    }else { // 没有越界
        return [self wx_objectAtIndex:index];
    }
}

@end
