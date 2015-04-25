//
//  StuModel.h
//  JustForTest_Obj-c
//
//  Created by mysticode on 15/4/21.
//  Copyright (c) 2015年 mysticode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeacherModel.h"
#import "CourseModel.h"

@interface StudentModel : NSObject
@property(assign, nonatomic) NSInteger *stuNo;
@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) NSInteger *age;
@property(strong, nonatomic) TeacherModel *teacherInCharge;
@property(strong, nonatomic) NSArray<CourseModel> *courses;

@property(strong, nonatomic) NSArray *arr;
@property(strong, nonatomic) NSDictionary *dic;
@end