//
//  UIViewController+WXMediator.m
//  WXKit
//
//  Created by 王家强 on 2018/1/31.
//

#import "UIViewController+WXMediator.h"
#import <objc/runtime.h>

@implementation NSObject(Runtime)

- (void)parseParameters {
    [self.mr_parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        @try {
            objc_property_t property = class_getProperty(self.class, key.UTF8String);
            if (!property){
                return;
            }
            //属性类型
            NSString *propertyAttribute = [NSString stringWithUTF8String:property_getAttributes(property)];
            NSArray* attributeItems = [propertyAttribute componentsSeparatedByString:@","];
            NSString *attributeString = [NSString stringWithUTF8String:property_getAttributes(property)];
            NSString *typeString = [[attributeString componentsSeparatedByString:@","] objectAtIndex:0];
            //类名，非基础类型
            NSString *classNameString = [self mr_getClassNameFromAttributeString:typeString];
            
            if ([attributeItems containsObject:@"R"]) {//如果属性是只读的，就不要进行解析了
                return;
            }
            //基础类型
            if ([value isKindOfClass:[NSNumber class]]) {
                //当对应的属性为基础类型或者 NSNumber 时才处理
                if ([typeString isEqualToString:@"Td"] || [typeString isEqualToString:@"Ti"] || [typeString isEqualToString:@"Tf"] || [typeString isEqualToString:@"Tl"] || [typeString isEqualToString:@"Tc"] || [typeString isEqualToString:@"Ts"] || [typeString isEqualToString:@"TI"]|| [typeString isEqualToString:@"Tq"] || [typeString isEqualToString:@"TQ"] || [typeString isEqualToString:@"TB"] ||[classNameString isEqualToString:@"NSNumber"]) {
                    [self setValue:value forKey:key];
                }
                else {
                    if ([classNameString isEqualToString:@"NSString"]) {
                        [self setValue:[value stringValue] forKey:key];
                    }
                    else{
                        NSLog(@"type error -- name:%@ attribute:%@ ", key, typeString);
                    }
                }
            }
            //字符串
            else if ([value isKindOfClass:[NSString class]]) {
                if ([classNameString isEqualToString:@"NSString"]) {
                    [self setValue:value forKey:key];
                }
                else if ([classNameString isEqualToString:@"NSMutableString"]) {
                    [self setValue:[NSMutableString stringWithString:value] forKey:key];
                }
                //对应的属性为基础类型或者NSNumber时，先转成 nsnumber
                else if ([classNameString isEqualToString:@"NSNumber"] || [typeString isEqualToString:@"Td"] || [typeString isEqualToString:@"Ti"] || [typeString isEqualToString:@"Tf"] || [typeString isEqualToString:@"Tl"] || [typeString isEqualToString:@"Tc"] || [typeString isEqualToString:@"Ts"] || [typeString isEqualToString:@"TI"]|| [typeString isEqualToString:@"Tq"] || [typeString isEqualToString:@"TQ"] || [typeString isEqualToString:@"TB"]) {
                    
                    NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
                    NSNumber *number = [formater numberFromString:value];
                    if (number!=nil)
                    {
                        [self setValue:number forKey:key];
                    }
                }
            }
            
            //其它不处理
            else
            {
                [self setValue:value forKey:key];
            }
            
        } @catch (NSException *exception) {}
    }];
}

- (NSString *)mr_getClassNameFromAttributeString:(NSString *)attributeString {
    NSString *className = nil;
    NSScanner *scanner = [NSScanner scannerWithString: attributeString];
    [scanner scanUpToString:@"T" intoString: nil];
    [scanner scanString:@"T" intoString:nil];
    if ([scanner scanString:@"@\"" intoString: &className]){
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&className];
    }
    return className;
}

@end

@implementation NSObject (Parameters)

- (void)setMr_parameters:(NSDictionary *)mr_parameters {
    objc_setAssociatedObject(self, @selector(mr_parameters), mr_parameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)mr_parameters {
    return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation UIViewController (WXMediator)


+ (UIViewController *)instantiateViewController:(NSString *)className
{
    return [self instantiateViewController:className parameters:nil];
}

+ (UIViewController *)instantiateViewController:(NSString *)className parameters:(NSDictionary *)parameters
{
    Class class = NSClassFromString(className);
    if (!class) {
        return [[self alloc] init];
    } else {
        id object = [[class alloc] init];
        if (parameters) {
            [object setValue:parameters forKey:@"mr_parameters"];
            [object parseParameters];
        }
        return object;
    }
}

@end
