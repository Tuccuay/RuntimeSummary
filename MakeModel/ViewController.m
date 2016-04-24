// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// MakeModel / 字典转模型

#import "ViewController.h"

#import "NSObject+Model.h"

#import "GithubUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 从网络请求数据
    NSString *githubAPI = @"https://api.github.com/users/Tuccuay";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:githubAPI]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                
                                                // 因为 Github 的 API 中有一个字段是 id
                                                // 而 id 在 Objective-C 中已经被占用
                                                // GithubUser *tuccuay = [GithubUser modelWithDict:dict];
                                                
                                                // 所以把 id 替换成 ID
                                                GithubUser *tuccuay = [GithubUser modelWithDict:dict updateDict:@{@"ID":@"id"}];
                                                
                                                // 给下面的 NSLog 打个断点
                                                // 从调试器里能看见上面的 tuccuay 模型已经转好了
                                                NSLog(@"mew~");
                                            }];
    [task resume];

}

@end
