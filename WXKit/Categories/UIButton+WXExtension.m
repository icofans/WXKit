//
//  UIButton+WXExtension.m
//  Pods-WXKit_Example
//
//  Created by 王家强 on 2018/1/31.
//

#import "UIButton+WXExtension.h"
#import <WXKit/WXKitMacro.h>

#define wx_objc_setter(key,value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
#define wx_objc_getter(key) objc_getAssociatedObject(self, key)
#define backgroundColorKEY(state) [NSString stringWithFormat:@"backgroundColor%zd",state]
#define borderColorKEY(state) [NSString stringWithFormat:@"borderColor%zd",state]

@implementation UIButton (WXExtension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wx_hook([self class], @selector(setHighlighted:), @selector(wx_setHighlighted:));
        wx_hook([self class], @selector(setEnabled:),  @selector(wx_setEnabled:));
        wx_hook([self class], @selector(setSelected:), @selector(wx_setSelected:));
    });
}

#pragma mark - override
- (void)wx_setSelected:(BOOL)selected {
    [self wx_setSelected:selected];
    [self updateButton];
}

- (void)wx_setEnabled:(BOOL)enabled {
    [self wx_setEnabled:enabled];
    [self updateButton];
}

- (void)wx_setHighlighted:(BOOL)highlighted {
    [self wx_setHighlighted:highlighted];
    [self updateButton];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (backgroundColor) {
        [self.backgroundColors setObject:backgroundColor forKey:@(state)];
        
        if(self.state == state) {
            self.backgroundColor = backgroundColor;
        }
    }
}

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state {
    if (borderColor) {
        [self.borderColors setObject:borderColor forKey:@(state)];
        
        if(self.state == state) {
            self.layer.borderColor = borderColor.CGColor;
        }
    }
}


#pragma mark - private method
- (void)updateButton {
    //updateBackgroundColor
    UIColor *backgroundColor = [self.backgroundColors objectForKey:@(self.state)];
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    } else {
        UIColor *normalColor = [self.backgroundColors objectForKey:@(UIControlStateNormal)];
        if (normalColor) {
            self.backgroundColor = normalColor;
        }
    }
    
    //updateBorderColor
    UIColor *borderColor = [self.borderColors objectForKey:@(self.state)];
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    } else {
        UIColor *normalColor = [self.borderColors objectForKey:@(UIControlStateNormal)];
        if (normalColor) {
            self.layer.borderColor = normalColor.CGColor;
        }
    }
}

- (void)setBackgroundColors:(NSMutableDictionary *)backgroundColors {
    wx_objc_setter(@selector(backgroundColors), backgroundColors);
}

- (NSMutableDictionary *)backgroundColors {
    NSMutableDictionary *backgroundColors = wx_objc_getter(@selector(backgroundColors));
    if(!backgroundColors) {
        backgroundColors = [[NSMutableDictionary alloc] init];
        self.backgroundColors = backgroundColors;
    }
    return backgroundColors;
}

- (void)setBorderColors:(NSMutableDictionary *)borderColors {
    wx_objc_setter(@selector(borderColors), borderColors);
}

- (NSMutableDictionary *)borderColors {
    NSMutableDictionary *borderColors = wx_objc_getter(@selector(borderColors));
    if (!borderColors) {
        borderColors = [NSMutableDictionary new];
        self.borderColors = borderColors;
    }
    return borderColors;
}


@end
