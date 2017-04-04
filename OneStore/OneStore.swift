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

open class OneStore<T: OneStoreValueProtocol>: OneStoreType {

  public typealias Value = T

  open let storeKey: String
  open let stack: Stack

  public final var rawStoreKey: String {
    return "\(stack.domain).\(storeKey)"
  }

  /// set value on "MainThread" synchronously.
  open var writeOnMainThread: Bool = true

  private let initialValue: T?

  public init(stack: Stack, key: String, initialValue: T? = nil) {

    precondition(key.isEmpty == false, "key must be not empty")

    self.storeKey = key
    self.stack = stack
    self.initialValue = initialValue
  }

  public convenience init<R: RawRepresentable>(stack: Stack, key: R, initialValue: T? = nil) where R.RawValue == String {
    self.init(stack: stack, key: key.rawValue, initialValue: initialValue)
  }

  open var value: T? {
    get {

      if let initialValue = initialValue, T.getOneStoreValue(stack.userDefaults, key: rawStoreKey) == nil {
        if Thread.isMainThread == false && writeOnMainThread {
          DispatchQueue.main.sync {
            initialValue.setOneStoreValue(stack.userDefaults, key: rawStoreKey)
          }
        } else {
          initialValue.setOneStoreValue(stack.userDefaults, key: rawStoreKey)
        }
      }

      return T.getOneStoreValue(stack.userDefaults, key: rawStoreKey)
    }
    set {
      if Thread.isMainThread == false && writeOnMainThread {
        DispatchQueue.main.sync {
          newValue?.setOneStoreValue(stack.userDefaults, key: rawStoreKey)
        }
      } else {
        newValue?.setOneStoreValue(stack.userDefaults, key: rawStoreKey)
      }
    }
  }
}

