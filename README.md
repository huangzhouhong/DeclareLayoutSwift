# DeclareLayoutSwift
## Installation
[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.You can install it with the following command:

```bash
$ brew update
$ brew install carthage
```
#### Cartfile
create a file named `Cartfile` with content:
```bash
github "https://github.com/huangzhouhong/DeclareLayoutSwift"
```
then,run command in terminal:
```bash
$ carthage update --platform iOS
```
drag all built *.framework(path:`./Carthage/Build/iOS`) into your Xcode project.
