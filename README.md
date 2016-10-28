# OneStore

[![CI Status](http://img.shields.io/travis/muukii/OneStore.svg?style=flat)](https://travis-ci.org/muukii/OneStore)
[![Version](https://img.shields.io/cocoapods/v/OneStore.svg?style=flat)](http://cocoapods.org/pods/OneStore)
[![License](https://img.shields.io/cocoapods/l/OneStore.svg?style=flat)](http://cocoapods.org/pods/OneStore)
[![Platform](https://img.shields.io/cocoapods/p/OneStore.svg?style=flat)](http://cocoapods.org/pods/OneStore)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A single value proxy for NSUserDefaults, with clean API.

With OneStore…
- Create one proxy(an `OneStore` object) for each NSUserDefaults value.
- Multiple NSUserDefaults and namespaces are supported with `Stacks`.

## Example

**Basic**

```swift
let name = OneStore<String>("name")
let age = OneStore<Int>("age")

name.value = "muukii"
age.value = 18
```

**Specify Stack**

```swift
let stack = Stack(userDefaults: NSUserDefaults(suiteName: "group.me.muukii.Fil")!, namespace: "me")
let name = OneStore<String>("name", stack: stack)
let age = OneStore<Int>("age", stack: stack)

name.value = "muukii"
age.value = 18
```

**Remove object**

```swift
let name = OneStore<String>("name", stack: stack)
name.value = nil
```

**Remove all objects on namespace**

```swift

let stack = Stack(userDefaults: NSUserDefaults.standardUserDefaults(), namespace: "me")
let name = OneStore<String>("name", stack: stack)

stack.removeAllObjectsOnNamespace()
/* or */
name.stack.removeAllObjectsOnNamespace()
```

**Realworld example**

```swift

enum Me {

    static let name = OneStore<String>("name", stack: Me.stack)
    static let age = OneStore<Int>("age", stack: Me.stack)

    private static let stack = Stack(userDefaults: NSUserDefaults.standardUserDefaults(), namespace: "me")
}

Me.name.value = "muukii"
```

## Requirements

Swift 3.0

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
