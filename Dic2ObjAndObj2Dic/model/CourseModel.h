//
//  Course.h
//  JustForTest_Obj-c
//
//  Created by mysticode on 15/4/23.
//  Copyright (c) 2015年 mysticode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeacherModel.h"
@protocol CourseModel <NSObject>
@end
@interface CourseModel : NSObject
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) TeacherModel *teacher;
@end
