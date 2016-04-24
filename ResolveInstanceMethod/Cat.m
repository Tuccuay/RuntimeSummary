//
//  Cat.m
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/21.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import "Cat.h"

#import <objc/message.h>

@implementation Cat

void run(id self, SEL _cmd,  NSNumber *metre) {
    NSLog(@"跑了%@米",metre);
}

// 当调用了一个未实现的方法会来到这里
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"run:")) {
        // 动态添加 run: 方法
        class_addMethod(self, @selector(run:), run, "v@:@");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
