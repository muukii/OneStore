// OneStore.swift
//
// Copyright (c) 2016 muukii
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

open class OneStore<T: OneStoreValueProtocol> {

  open let storeKey: String
  open let stack: Stack

  /// Run get value, set value on "MainThread" synchronously.
  open var synchronouslyOnMainThread: Bool = false

  public init(_ key: String, stack: Stack = Stack.defaultStack) {

    self.storeKey = key
    self.stack = stack
  }

  public init<T: RawRepresentable>(_ key: T, stack: Stack = Stack.defaultStack) where T.RawValue == String {

    self.storeKey = key.rawValue
    self.stack = stack
  }

  open var value: T? {
    get {
      if Thread.isMainThread == false && synchronouslyOnMainThread {
        return DispatchQueue.main.sync {
          return T.getOneStoreValue(stack.userDefaults, key: actualStoreKey)
        }
      } else {
        return T.getOneStoreValue(stack.userDefaults, key: actualStoreKey)
      }
    }
    set {
      if Thread.isMainThread == false && synchronouslyOnMainThread {
        DispatchQueue.main.sync {
          newValue?.setOneStoreValue(stack.userDefaults, key: actualStoreKey)
        }
      } else {
        newValue?.setOneStoreValue(stack.userDefaults, key: actualStoreKey)
      }
    }
  }

  fileprivate var actualStoreKey: String {
    return "\(stack.namespace).\(storeKey)"
  }
}

