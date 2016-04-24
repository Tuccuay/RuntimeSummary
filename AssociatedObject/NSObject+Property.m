//
//  NSObject+Property.m
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/21.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import "NSObject+Property.h"

#import <objc/message.h>

@implementation NSObject (Property)

// 这种方法生成的变量不受对象控制
// NSString *_name;

- (void)setName:(NSString *)name {
    // 把属性关联给对象
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    // 取出属性
    return objc_getAssociatedObject(self, "name");
}

@end
