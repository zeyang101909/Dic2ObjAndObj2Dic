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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *dic = @{
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
//        NSDictionary *dic2 = @{
//                              @"stuNo":@123,
//                              @"name":@"罗建伟",
//                              @"age":@18,
//                              @"teacherInCharge":@{
//                                      @"name":@"又是罗建伟",
//                                      @"age":@188
//                                      },
//                              @"courses":@{
//                                               @"name":@"1~名字就一代号而已",
//                                               @"teacher":@{
//                                                       @"name":@"还是罗建伟",
//                                                       @"age":@188
//                                                       }
//                                               }
//        };
        StudentModel *s = [JWLCommonUtils dictionary:dic toObject:[StudentModel class]];
        NSDictionary *d = [JWLCommonUtils objectToDictionary:s];
        NSLog(@"~~~resultDic==>%@",d);
        NSLog(@"%@",[d valueForKey:@"name"]);
    
    }
    return 0;
}