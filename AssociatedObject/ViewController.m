// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// AssociatedObject / 动态关联属性

#import "ViewController.h"

#import "NSObject+Property.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *anObject = [[NSObject alloc] init];
    
    anObject.name = @"Alton";
    
    // NSObject 并没有 name 这个属性，通过 Runtime 成功的添加了这个属性
    NSLog(@"%@", anObject.name);
    
    // 输出：
    // 2016-04-21 22:15:24.502 AssociatedObject[21577:1914668] Alton
}

@end
