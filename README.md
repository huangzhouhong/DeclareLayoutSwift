# DeclareLayoutSwift
## 前言
iOS UI制作有两种：代码手写UI，xib或StoryBoard（使用Interface Builder，简称IB）。
哪一种更好，可能没有定论。但IB才是主流。
主要是因为手写UI有两个缺点：
- 开发效率不如IB
- 不够直观，尤其在代码中创建约束

IB也有缺点
要在下面这个例子中插多一行，就要修改原有的约束
![示例1](https://upload-images.jianshu.io/upload_images/6719795-3f013514ff623b6a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

再比如，自定义一个`UITableViewCell`，需要这些步骤：
- 在Storyboard中或创建xib文件
- 做好布局和约束
- 创建`UITableViewCell`子类
- 拖线，创建outlet（插座变量）
- 在适当的时候更新这些插座变量

我在工作中主要还是使用IB来做UI，但我依然希望有一种方法，可以让我一直在编辑器里工作，不用在IB和编辑器之前切换，不用创建大量的Storyboard和xib，同时又能兼顾直观、开发效率和运行效率。这就是[DeclareLayoutSwift](https://github.com/huangzhouhong/DeclareLayoutSwift)的目标。

## 简介
[DeclareLayoutSwift](https://github.com/huangzhouhong/DeclareLayoutSwift)使用布局容器和界面元素（`UIElement`及其子类）来构建界面。
- 布局容器动态计算`children`（子元素）的大小和位置。**不使用**约束（constraints），而是最终设置`UIView`的`frame`。因为约束也是自动计算位置和大小，转换为约束相当于Auto Layout又要再计算一次。
- 界面可以看是一棵树，通过嵌套不同的容器，组合不同的规则，来声明界面如何展示
## 简单示例
```swift
StackPanel {
[Image(.image <- "icon1", .hAlign <- .Center),
Label(.text <- "Name", .hAlign <- .Center)]
}
```

![StackPanel示例](https://upload-images.jianshu.io/upload_images/6719795-4b514d8d025d2be2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


- StackPanel创建一个布局，使`children`按水平或竖直方向排列（默认是竖直）
- Image创建一个图片，`.image <- "icon1"`设置图片来源，可以是项目中的图片，也可以是url。
- `<-`是自定义运算符，可以理解为属性赋值。由于Swift构造函数不能任意改变参数的顺序，为了支持支持任意数量、任意顺序的属性的初始化，同时仍是强类型的，所以使用自定义运算符。例如我想把`hAlign`属性放在前面
- `.hAlign <- .Center`指定元素水平居中。在`StackPanel`中，竖直排列默认拉伸水平方向，水平排列默认拉伸竖直方向。在这个例子中，如果不指定水平对齐方式，图片会充满水平方向（.Stretch），然后保持图片原有比例。

## 示例2 Table
```swift
class TableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
override func viewDidLoad() {
super.viewDidLoad()

self.view.backgroundColor = .white
self.view.hostElement {
Table(.delegate <- self, .dataSource <- self)
}
}

private func generateRandomString() -> String {
let text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
let randomIndex = arc4random_uniform(UInt32(text.count))
let index = text.index(text.startIndex, offsetBy: Int(randomIndex))
return String(text[...index])
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return 100
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let randString = generateRandomString()

let element = Grid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20)) {
[Label(.text <- String(indexPath.row)),
Label(.gridColumnIndex <- 1, .margin <- Insets(left: 8), .text <- randString, .numberOfLines <- 0)]
}

return tableView.makeCell(element: element)
}
}
```

![示例2 Table](https://upload-images.jianshu.io/upload_images/6719795-de525fba8bb8eff3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 没有为View Controller 创建Storyboard或xib
- 没有为Cell创建xib
- 没有显式指定任何元素大小和位置，只是设置了内边距、外边距，自动换行等等
- 不需要设置Cell高度，根据内容计算

## 安装
如果未安装[Carthage](https://github.com/Carthage/Carthage) ，执行
```bash
$ brew update
$ brew install carthage
```
### 1. 运行Demo
切到项目根目录下（`Cartfile`所在目录），执行
```bash
$ carthage update
```
打开`DeclareLayoutSwift.xcworkspace`

### 2. 将DeclareLayoutSwift添加到你的项目
创建文件名为 `Cartfile`的文件，文件内容：
```bash
github "https://github.com/huangzhouhong/DeclareLayoutSwift"
```
运行:
```bash
$ carthage update --platform iOS
```
将 *.framework(路径:`./Carthage/Build/iOS`) 拖入到 Xcode.
