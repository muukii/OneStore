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

open class OneStore<T: Codable> : OneStoreType {

  public typealias Value = T

  open let storeKey: String
  open let stack: Stack

  public final var rawStoreKey: String {
    return "\(stack.domain).\(storeKey)"
  }

  private let initializeValue: T?

  /// Initialize
  ///
  /// - Parameters:
  ///   - stack:
  ///   - key:
  ///   - initialize: If OneStore.value is nil, set specified value as initial value.
  public init(stack: Stack, key: String, initialize value: T? = nil) {

    precondition(key.isEmpty == false, "key must be not empty")

    self.storeKey = key
    self.stack = stack
    self.initializeValue = value
    if self.value == nil {
      self.value = value
    }
    stack.addManagedKey(rawStoreKey)
  }

  open var value: T? {
    get {

      if isPrimitive(type: T.self) {
        return stack.userDefaults.value(forKey: rawStoreKey) as? T
      }

      guard let data = stack.userDefaults.data(forKey: rawStoreKey) else {
        return nil
      }

      do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Box<T>.self, from: data)
        return decoded.value
      } catch {
        assertionFailure("OneStore Error : \(error)")
        return nil
      }
    }
    set {
      guard let value = newValue else {
        stack.remove(key: rawStoreKey)
        return
      }

      if isPrimitive(type: T.self) {
        stack.userDefaults.set(value, forKey: rawStoreKey)
        return
      }

      do {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(Box(value))
        stack.userDefaults.set(encoded, forKey: rawStoreKey)
      } catch {
        assertionFailure("OneStore Error : \(error)")
      }
    }
  }

  public func reset() {
    value = initializeValue
  }

  private func isPrimitive<ValueType>(type: ValueType.Type) -> Bool {
    switch type {
    case 
    is String.Type,
    is Bool.Type,
    is Int.Type,
    is Float.Type,
    is Double.Type:
      return true
    default:
      return false
    }
  }
}

