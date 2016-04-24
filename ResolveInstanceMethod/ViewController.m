// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// ResolveInstanceMethod / 动态加载方法

#import "ViewController.h"

#import "Cat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Cat *billy = [[Cat alloc] init];
    
    // 这个时候 billy 对象并没有 run: 方法
    // 所以会进入 + (BOOL)resolveClassMethod:(SEL)sel 处理
    // 然后方法被动态添加
    [billy performSelector:@selector(run:) withObject:@10];
}

@end
