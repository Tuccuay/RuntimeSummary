//
//  Cat.m
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/23.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import "Cat.h"

@implementation Cat

// 在没有找到方法时，会先调用此方法，可用于动态添加方法
/*
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}
 */

// 如果上面返回 NO，就会进入这一步，用于指定备选响应此 SEL 的对象
// 如果返回 self 就会死循环
/*
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}
 */

// 指定方法签名，若返回 nil，则不会进入下一步，而是无法处理消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"stoke"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// 当实现了此方法后，-doesNotRecognizeSelector: 将不会被调用
// 如果要测试找不到方法，可以注释掉这一个方法
// 在这里进行消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    // 我们还可以改变方法选择器
    [anInvocation setSelector:@selector(touch)];
    // 改变方法选择器后，还需要指定是哪个对象的方法
    [anInvocation invokeWithTarget:self];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"无法处理消息：%@", NSStringFromSelector(aSelector));
}

+ (void)touch {
    NSLog(@"Cat 没有实现 stoke 方法，并且成功的转成了 touch 方法");
}

+ (void)stoke {
    Cat *carson = [[Cat alloc] init];
    [Cat performSelector:@selector(touch) withObject:nil afterDelay:0];
}


@end
