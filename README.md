# OneStore

[![CI Status](http://img.shields.io/travis/muukii/OneStore.svg?style=flat)](https://travis-ci.org/muukii/OneStore)
[![Version](https://img.shields.io/cocoapods/v/OneStore.svg?style=flat)](http://cocoapods.org/pods/OneStore)
[![License](https://img.shields.io/cocoapods/l/OneStore.svg?style=flat)](http://cocoapods.org/pods/OneStore)
[![Platform](https://img.shields.io/cocoapods/p/OneStore.svg?style=flat)](http://cocoapods.org/pods/OneStore)

## Example

**Basic**

```swift
let name = Defaults<String>("name")
let age = Defaults<Int>("age")

name.value = "muukii"
age.value = "18"
```

**Specify Stack**

```swift
let stack = Stack(userDefaults: NSUserDefaults.standardUserDefaults(), namespace: "me")
let name = Defaults<String>("name", stack: stack)
let age = Defaults<Int>("age", stack: stack)

name.value = "muukii"
age.value = "18"
```

**Remove object**

```swift
let name = Defaults<String>("name", stack: stack)
name.value = nil
```

**Remove all objects on namespace**

```swift

let stack = Stack(userDefaults: NSUserDefaults.standardUserDefaults(), namespace: "me")
let name = Defaults<String>("name", stack: stack)

stack.removeAllObjectsOnNamespace()
/* or */
name.stack.removeAllObjectsOnNamespace()
```

**Realworld example**

```swift

enum Me {

    static let name = Defaults<String>("name", stack: Me.stack)
    static let age = Defaults<Int>("age", stack: Me.stack)

    private static let stack = Stack(userDefaults: NSUserDefaults.standardUserDefaults(), namespace: "me")
}

Me.name.value = "muukii"
```

## Requirements

Swift2.2

## Installation

OneStore is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OneStore"
```

## Author

muukii, m@muukii.me

## License

OneStore is available under the MIT license. See the LICENSE file for more info.
