//
//  Cat.m
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/21.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import "Cat.h"

@implementation Cat

- (void)eat {
    NSLog(@"burbur~");
}

- (void)run:(NSUInteger)metre
{
    NSLog(@"跑了 %ld 米", metre);
}

@end
