//
//  NSObject+Model.m
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/23.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import "NSObject+Model.h"

#import <objc/message.h>

@implementation NSObject (Model)

+ (instancetype)modelWithDict:(NSDictionary *)dict updateDict:(NSDictionary *)updateDict {
    id model = [[self alloc] init];
    // 遍历模型中属性
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0 ; i < count; i++) {
        Ivar ivar = ivars[i];
        // 属性名称
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        // 模型中属性名对应字典中的key
        if (value == nil) {
            if (updateDict) {
                NSString *keyName = updateDict[ivarName];
                value = dict[keyName];
            }
        }
        [model setValue:value forKeyPath:ivarName];
    }
    return model;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [self modelWithDict:dict updateDict:nil];
}

@end
