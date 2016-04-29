![RuntimeSummary](https://github.com/Tuccuay/RuntimeSummary/raw/master/Assets/RuntimeSummary.png)

# RuntimeSummary
一个集合了常用 Objective-C Runtime 使用方法的 Playground

## 目录

* [如何使用这个 Playground](#Playground)
* [消息机制介绍 / Messaging](#Messaging)
* [方法交换 / MethodSwizzling](#MethodSwizzling)
* [动态加载方法 / ResolveInstanceMethod](#ResolveInstanceMethod)
* [消息转发 / ForwardMessage](#ForwardMessage)
* [动态关联属性 / AssociatedObject](#AssociatedObject)
* [字典转模型 / MakeModel](#MakeModel)
* [对象归档、解档 / ObjectArchive](#ObjectArchive)
* [更多](#More)

<h2 id="Playground">如何使用这个 Playground </h2>

![Screenshot](https://github.com/Tuccuay/RuntimeSummary/raw/master/Assets/Screenshot.png)

先选择 Scheme，然后 Run！

<h2 id="Messaging">消息机制介绍 / Messaging</h2>

```objc
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
```

<h2 id="MethodSwizzling">方法交换 / MethodSwizzling</h2>

```objc
+ (void)load {
    // 获取到两个方法
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method tuc_imageNamedMethod = class_getClassMethod(self, @selector(tuc_imageNamed:));

    // 交换方法
    method_exchangeImplementations(imageNamedMethod, tuc_imageNamedMethod);
}

+ (UIImage *)tuc_imageNamed:(NSString *)name {
    // 因为来到这里的时候方法实际上已经被交换过了
    // 这里要调用 imageNamed: 就需要调换被交换过的 tuc_imageNamed
    UIImage *image = [UIImage tuc_imageNamed:name];

    // 判断是否存在图片
    if (image) {
        NSLog(@"加载成功");
    } else {
        NSLog(@"加载失败");
    }

    return image;
}
```

<h2 id="ResolveInstanceMethod">动态加载方法 / ResolveInstanceMethod</h2>

```objc
void run(id self, SEL _cmd,  NSNumber *metre) {
    NSLog(@"跑了%@米",metre);
}

// 当调用了一个未实现的方法会来到这里
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"run:")) {
        // 动态添加 run: 方法
        class_addMethod(self, @selector(run:), run, "v@:@");

        return YES;
    }

    return [super resolveInstanceMethod:sel];
}
```

<h2 id="ForwardMessage">消息转发 / ForwardMessage</h2>

```objc
#pragma mark - 实例方法

//  第一步
//  在没有找到方法时，会先调用此方法，可用于动态添加方法
//  返回 YES 表示相应 selector 的实现已经被找到并添加到了类中，否则返回 NO

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
}

//  第二步
//  如果第一步的返回 NO 或者直接返回了 YES 而没有添加方法，该方法被调用
//  在这个方法中，我们可以指定一个可以返回一个可以响应该方法的对象
//  如果返回 self 就会死循环

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

//  第三步
//  如果 `forwardingTargetForSelector:` 返回了 nil，则该方法会被调用，系统会询问我们要一个合法的『类型编码(Type Encoding)』
//  https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
//  若返回 nil，则不会进入下一步，而是无法处理消息

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
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

- (void)touch {
    NSLog(@"Cat 没有实现 -stoke 方法，并且成功的转成了 -touch 方法");
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"无法处理消息：%@", NSStringFromSelector(aSelector));
}
```

<h2 id="AssociatedObject">动态关联属性 / AssociatedObject</h2>

```objc
- (void)setName:(NSString *)name {
    // 把属性关联给对象
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    // 取出属性
    return objc_getAssociatedObject(self, "name");
}
```

<h2 id="MakeModel">字典转模型 / MakeModel</h2>

```objc
+ (instancetype)modelWithDict:(NSDictionary *)dict updateDict:(NSDictionary *)updateDict {
    id model = [[self alloc] init];
    // 遍历模型中属性
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0 ; i < count; i++) {
        Ivar ivar = ivars[i];
        // 属性名称
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        // 模型中属性名对应字典中的key
        if (value == nil) {
            if (updateDict) {
                NSString *keyName = updateDict[ivarName];
                value = dict[keyName];
            }
        }
        [model setValue:value forKeyPath:ivarName];
    }
    return model;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [self modelWithDict:dict updateDict:nil];
}
```

<h2 id="ObjectArchive">对象归档、解档 / ObjectArchive</h2>

```objc
- (void)tuc_initWithCoder:(NSCoder *)aDecoder {
    // 不光归档自身的属性，还要循环把所有父类的属性也找出来
    Class selfClass = self.class;
    while (selfClass &&selfClass != [NSObject class]) {

        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(selfClass, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];

            // 如果有实现忽略属性的方法
            if ([self respondsToSelector:@selector(ignoredProperty)]) {
                // 就跳过这个属性
                if ([[self ignoredProperty] containsObject:key]) continue;
            }

            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }

}

- (void)tuc_encodeWithCoder:(NSCoder *)aCoder {
    Class selfClass = self.class;
    while (selfClass &&selfClass != [NSObject class]) {

        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];

            if ([self respondsToSelector:@selector(ignoredProperty)]) {
                if ([[self ignoredProperty] containsObject:key]) continue;
            }

            id value = [self valueForKeyPath:key];
            [aCoder encodeObject:value forKey:key];
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }
}
```

<h2 id="More">更多</h2>

觉得还有其它常用的 Runtime 用法没有讲到？欢迎 Pull Request！

或者懒得动手想看看大家的思路？没问题，提个 [issue](https://github.com/Tuccuay/RuntimeSummary/issues/new) ！

觉得看了这个 Playground 豁然开朗？来 Star 一个吧！

## License

RuntimeSummary is released under the MIT license. See [LICENSE](https://github.com/Tuccuay/RuntimeSummary/blob/master/LICENSE) .
