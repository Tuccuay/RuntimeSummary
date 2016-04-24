// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// MethodSwizzling / 方法交换

#import "ViewController.h"

#import "UIImage+Success.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这里调用的是 imageNamed
    // 但实际上方法已经在 UIImage+Success 分类中被交换了
    // 所以这个能够提示图片是否加载成功
    UIImage *image = [UIImage imageNamed:@"picture"];
    
    // 因为名为 picture 的图片不存在，所以输出是
    // 2016-04-21 21:40:31.196 MethodSwizzling[20966:1866151] 加载失败
}

@end
