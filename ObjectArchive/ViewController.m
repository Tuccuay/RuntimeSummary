// RuntimeSummary - 一个集合了常用 Objective-C Runtime 用法的 Playground
// https://github.com/Tuccuay/RuntimeSummary

// ObjectArchive / 对象归档、解档

#import "ViewController.h"

#import "Cat.h"

@interface ViewController ()

@property (nonatomic, strong) Cat *anCat;
@property (nonatomic, copy) NSString *path;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.path = NSHomeDirectory();
    self.path = [NSString stringWithFormat:@"%@/anCat", self.path];
    
    self.anCat = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    
    if (!self.anCat) {
        self.anCat = [[Cat alloc] init];
    }
    
    self.textField.text = self.anCat.name;
}

- (IBAction)saveButtonClicked:(UIButton *)sender {
    self.anCat.name = self.textField.text;
    
    [NSKeyedArchiver archiveRootObject:self.anCat toFile:self.path];
}

@end
