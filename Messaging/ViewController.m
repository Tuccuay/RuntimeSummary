// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// Messaging / 消息机制介绍

#import "ViewController.h"

#import "Cat.h"

#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个对象
    // Cat *harlan = [[Cat alloc] init];
    
    // 使用 Runtime 创建一个对象
    // 根据类名获取到类
    Class catClass = objc_getClass("Cat");
    
    // 同过类创建实例对象
    // 如果这里报错，请将 Build Setting -> Enable Strict Checking of objc_msgSend Calls 改为 NO
    Cat *harlan = objc_msgSend(catClass, @selector(alloc));
    
    // 初始化对象
    // harlan = [harlan init];
    
    // 通过 Runtime 初始化对象
    harlan = objc_msgSend(harlan, @selector(init));
    
    // 调用对象方法
    // [harlan eat];
    
    // 通过 Runtime 调用对象方法
    // 调用的这个方法没有声明只有实现所以这里会有警告
    // 但是发送消息的时候会从方法列表里寻找方法
    // 所以这个能够成功执行
    objc_msgSend(harlan, @selector(eat));
    
    // 输出： 2016-04-21 21:10:20.733 Messaging[20696:1825249] burbur~
    
    // 当然，objc_msgSend 可以传递参数
    Cat *alex = objc_msgSend(objc_msgSend(objc_getClass("Cat"), sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(alex, @selector(run:), 10);
}

@end
