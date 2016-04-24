//
//  UIImage+Success.m
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/21.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import "UIImage+Success.h"

#import <objc/message.h>

@implementation UIImage (Success)

+ (void)load {
    // 获取到两个方法
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method tuc_imageNamedMethod = class_getClassMethod(self, @selector(tuc_imageNamed:));
    
    // 交换方法
    method_exchangeImplementations(imageNamedMethod, tuc_imageNamedMethod);
}

+ (UIImage *)tuc_imageNamed:(NSString *)name {
    // 因为来到这里的时候方法实际上已经被交换过了
    // 这里要调用 imageNamed: 就需要调换被交换过的 tuc_imageNamed
    UIImage *image = [UIImage tuc_imageNamed:name];
    
    // 判断是否存在图片
    if (image) {
        NSLog(@"加载成功");
    } else {
        NSLog(@"加载失败");
    }
    
    return image;
}

@end
