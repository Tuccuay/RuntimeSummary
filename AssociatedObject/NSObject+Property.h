//
//  NSObject+Property.h
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/21.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)

// @property 在分类中只会生成 getter/setter 方法
// 不会生成成员属性
@property NSString *name;

@end
