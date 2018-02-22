//
//  NSTimer+Category.h
//  WXKit
//
//  Created by 张鹏 on 2018/2/17.
//  Copyright © 2018年 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WXCategory)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void(^)(void))block
                                    repeats:(BOOL)repeats;
@end
