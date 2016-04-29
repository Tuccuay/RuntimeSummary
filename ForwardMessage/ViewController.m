// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// ForwardMessage / 消息转发

#import "ViewController.h"
#import "Cat.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)instanceMethodCalling {
    [[Cat new] stoke];
}

- (IBAction)classMethodCalling {
    [Cat stoke];
}

@end
