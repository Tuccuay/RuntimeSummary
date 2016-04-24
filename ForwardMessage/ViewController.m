// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// ForwardMessage / 消息转发

#import "ViewController.h"

#import "Cat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Cat stoke];
    
    // 输出：
    // 2016-04-24 00:27:12.823 ForwardMessage[50298:3350384] Cat 没有实现 stoke 方法，并且成功的转成了 touch 方法
}

@end
