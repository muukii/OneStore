//
// NonOptionalOneStore.swift
//
// Copyright (c) 2017 muukii
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

open class NonOptionalOneStore<T: Codable> : OneStoreType {

  public let source: OneStore<T>
  
  private let _makeInitialValue: () -> T

  public final var storeKey: String {
    return source.storeKey
  }

  public final var stack: Stack {
    return source.stack
  }

  public final var rawStoreKey: String {
    return source.rawStoreKey
  }

  open var value: T {
    get {
      guard let value = source.value else {
        assertionFailure("This feature has broken😭")
        return _makeInitialValue()
      }
      return value
    }
    set {
      source.value = newValue
    }
  }

  public init(stack: Stack, key: String, makeInitialValue: @escaping () -> T) {
    self.source = OneStore<T>(stack: stack, key: key, makeInitialValue: makeInitialValue)
    self._makeInitialValue = makeInitialValue
  }

  public func reset() {
    source.reset()
  }
}
