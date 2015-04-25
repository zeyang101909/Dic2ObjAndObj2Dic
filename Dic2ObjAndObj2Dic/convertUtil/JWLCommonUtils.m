//
//  JWLCommonUtils.m
//  JustForTest_Obj-c
//
//  Created by mysticode on 15/4/23.
//  Copyright (c) 2015年 mysticode. All rights reserved.
//
#import <objc/runtime.h>
#import "JWLCommonUtils.h"

@implementation JWLCommonUtils
+(NSDictionary *) objectToDictionary:(id)obj{
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    Class c = [obj class];
    unsigned int outCount;
    Ivar *vars = class_copyIvarList(c, &outCount);
    for (int i=0; i < outCount; i++) {
        NSString *pName = [NSString stringWithUTF8String:ivar_getName(vars[i])];
        pName = [self removeUnderLine:pName];
        id value = object_getIvar (obj,vars[i]);
        NSString *pType = [NSString stringWithUTF8String:ivar_getTypeEncoding(vars[i])];
        if (![self needToHandle:pType]) {
            [resultDic setValue:value forKey:pName];
        }else{
            if ([pType containsString:@"NSArray"]) {
                NSMutableArray *array = [NSMutableArray array];
                for(id o in value){
                    NSDictionary *d = [self objectToDictionary:o];
                    [array addObject:d];
                }
                [resultDic setValue:array forKey:pName];
            }else{
                [resultDic setValue:[self objectToDictionary:value] forKey:pName];
            }
        }
        
    }
    return resultDic;
}
+(id)dictionary:(NSDictionary*)dic toObject:(Class)c{
    id obj = [[c alloc]init];
    unsigned int outCount;
    Ivar *vars = class_copyIvarList(c, &outCount);
    for(int i = 0; i < outCount; i++){
        NSString *pName = [NSString stringWithUTF8String:ivar_getName(vars[i])];
        pName = [self removeUnderLine:pName];
        id value = [dic valueForKey:pName];
        if (value!=nil) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                NSString *pType = [NSString stringWithUTF8String:ivar_getTypeEncoding(vars[i])];
                if (![pType containsString:@"NSArray"]) {
                    Class subClass = [self dictionaryClassFromTypeEncoding:pType];
                    if (subClass == nil) {
                        NSLog(@"不存在名称为%@的类。",pType);
                        continue;
                    }
                    object_setIvar(obj, vars[i], [self dictionary:value toObject:subClass]);
                }else{
                    Class subClass = [self arrayItemClassStringWithTypeEncoding:pType];
                    if (subClass == nil) {
                        NSLog(@"不存在名称为%@的类。",pType);
                        continue;
                    }
                    NSArray *array = @[[self dictionary:value toObject:subClass]];
                    object_setIvar(obj, vars[i], array);
                }
            }else if([value isKindOfClass:[NSArray class]]){
                NSString *pType = [NSString stringWithUTF8String:ivar_getTypeEncoding(vars[i])];
                Class subClass = [self arrayItemClassStringWithTypeEncoding:pType];
                if (subClass == nil) {
                    NSLog(@"不存在名称为%@的类。",pType);
                    continue;
                }
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dic in value) {
                    [array addObject:[self dictionary:dic toObject:subClass]];
                }
                object_setIvar(obj, vars[i], array);
            }else{
                object_setIvar (obj, vars[i], value);
            }
        }
    }
    free(vars);
    return obj;
}
#pragma mark - util methods
/**
 *  移除字段名称前面的下划线
 *
 *  @param name 字段名称
 *
 *  @return 处理后的字段名称
 */
+(NSString*)removeUnderLine:(NSString*)name{
    if ([name hasPrefix:@"_"]) {
        return [name substringFromIndex:1];
    }
    return name;
}
/**
 *  获取字典对应的model类型
 *
 *  @param typeEncoding 字段类型编码
 *
 *  @return 字典对应的model类型
 */
+(Class)dictionaryClassFromTypeEncoding:(NSString *)typeEncoding{
    NSString *className = [typeEncoding substringWithRange:NSMakeRange(2, [typeEncoding length]-3)];
    //NSLog(@"typeEncoding:%@ 类名:%@",typeEncoding,className);
    return NSClassFromString(className);
}
/**
 *  获取数组元素对应的model类型
 *
 *  @param typeEncoding 字段类型编码
 *
 *  @return 数组元素对应的model类型
 */
+(Class)arrayItemClassStringWithTypeEncoding:(NSString *)typeEncoding{
    typeEncoding = [typeEncoding substringWithRange:NSMakeRange(2, [typeEncoding length]-3)];
    NSRange start = [typeEncoding rangeOfString:@"<"];
    NSRange end = [typeEncoding rangeOfString:@">"];
    NSRange r = NSMakeRange(start.location+1, end.location-start.location-1);
    NSString *className = [typeEncoding substringWithRange:r];
    //NSLog(@"typeEncoding:%@ 类名:%@",typeEncoding,className);
    return NSClassFromString(className);
}
/**
 *  判断字段是否需要特殊处理(是对象还是直接设置值)
 *
 *  @param pType 字段的类型编码
 *
 *  @return BOOL
 */
+(BOOL)needToHandle:(NSString *)pType{
    if (![pType hasPrefix:@"@"]) {
        return NO;
    }else if ([pType containsString:@"NSString"]) {
        return NO;
    }else if ([pType containsString:@"NSDictionary"]){
        return NO;
    }else if([pType containsString:@"NSArray"] && ![pType containsString:@"<"]){
        return NO;
    }
    return YES;
}
@end
