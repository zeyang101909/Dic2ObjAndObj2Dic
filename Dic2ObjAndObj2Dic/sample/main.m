//
//  main.m
//  JustForTest_Obj-c
//
//  Created by mysticode on 15/3/24.
//  Copyright (c) 2015年 mysticode. All rights reserved.
//
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "StudentModel.h"
#import "JWLCommonUtils.h"
#import "NSObject+JWLObjDicConvert.h"

NSDictionary* getDic1();
NSDictionary* getDic2();
void extensionTest();
void commonUtilsTest();
void excute(void (*fn)(),NSString *comment);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        excute(extensionTest, @"类扩展方式实现(way of using category)");
        excute(commonUtilsTest, @"工具方法方式实现(way of using common util method)");
    }
    return 0;
}


void extensionTest(){
    StudentModel *s = [StudentModel initWithDic:getDic1()];
    NSDictionary *d = [s toDictionary];
    NSLog(@"resultDic==>%@",d);
    NSLog(@"%@",[d valueForKey:@"name"]);
}

void commonUtilsTest(){
    StudentModel *s = [JWLCommonUtils dictionary:getDic1() toObject:[StudentModel class]];
    NSDictionary *d = [JWLCommonUtils objectToDictionary:s];
    NSLog(@"resultDic==>%@",d);
    NSLog(@"%@",[d valueForKey:@"name"]);
}

NSDictionary* getDic1(){
    return @{
             @"stuNo":@123,
             @"name":@"罗建伟",
             @"age":@18,
             @"teacherInCharge":@{
                     @"name":@"又是罗建伟",
                     @"age":@188
                     },
             @"courses":@[@{
                              @"name":@"1~名字就一代号而已",
                              @"teacher":@{
                                      @"name":@"还是罗建伟",
                                      @"age":@188
                                      }
                              },@{
                              @"name":@"2~名字就一代号而已",
                              @"teacher":@{
                                      @"name":@"没别的老师了吗",
                                      @"age":@188
                                      }
                              },@{
                              @"name":@"3~名字就一代号而已",
                              @"teacher":@{
                                      @"name":@"还是我来当老师吧",
                                      @"age":@188
                                      }
                              }]
             };
}

NSDictionary* getDic2(){
    return @{
             @"stuNo":@123,
             @"name":@"罗建伟",
             @"age":@18,
             @"teacherInCharge":@{
                     @"name":@"又是罗建伟",
                     @"age":@188
                     },
             @"courses":@{
                     @"name":@"1~名字就一代号而已",
                     @"teacher":@{
                             @"name":@"还是罗建伟",
                             @"age":@188
                             }
                     }
             };
}

void excute(void (*fn)(),NSString *comment){
    NSLog(@"----------------------%@----------------------开始",comment);
    fn();
    NSLog(@"----------------------%@----------------------结束",comment);
}

