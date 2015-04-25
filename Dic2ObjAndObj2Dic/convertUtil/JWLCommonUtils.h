//
//  JWLCommonUtils.h
//  JustForTest_Obj-c
//
//  Created by mysticode on 15/4/23.
//  Copyright (c) 2015年 mysticode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWLCommonUtils : NSObject
/**
 *  将对象转换成字典
 *
 *  @param obj 待转换的对象
 *
 *  @return 转换成功的字典
 */
+(NSDictionary *) objectToDictionary:(id)obj;
/**
 *  将字典转换成对象
 *
 *  @param dic 待转换字典
 *  @param c   要转换成的对象的类型
 *
 *  @return 转换成功后的对象
 */
+(id)dictionary:(NSDictionary*)dic toObject:(Class)c;
@end
