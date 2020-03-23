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
import os.lock

open class OneStore<T: Codable> : OneStoreType {

  public typealias Value = T

  public let storeKey: String
  public let stack: Stack
  
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()
  
  private var _cached: T?

  public final var rawStoreKey: String {
    return "\(stack.domain).\(storeKey)"
  }

  private let makeInitialValue: () -> T?
  
  private var lock = os_unfair_lock_s()

  /// Initialize
  ///
  /// - Parameters:
  ///   - stack:
  ///   - key:
  ///   - initialize: If OneStore.value is nil, set specified value as initial value.
  public init(stack: Stack, key: String, makeInitialValue: @escaping () -> T? = { nil }) {

    precondition(key.isEmpty == false, "key must be not empty")

    self.storeKey = key
    self.stack = stack
    self.makeInitialValue = makeInitialValue
    stack.addManagedKey(rawStoreKey)
  }

  open var value: T? {
    get {      
      os_unfair_lock_lock(&lock); defer { os_unfair_lock_unlock(&lock) }
      return getValue()
    }
    set {
      os_unfair_lock_lock(&lock); defer { os_unfair_lock_unlock(&lock) }
      setValue(newValue: newValue)
    }
  }
  
  @inline(__always)
  private func getValue() -> T? {
    if let cached = _cached {
      return cached
    }
    
    if stack.userDefaults.object(forKey: rawStoreKey) == nil {
      setValue(newValue: makeInitialValue())
    }
    
    if isPrimitive(type: T.self) {
      return stack.userDefaults.value(forKey: rawStoreKey) as? T
    }
    
    guard let data = stack.userDefaults.data(forKey: rawStoreKey) else {
      return nil
    }
    
    do {
      let decoded = try decoder.decode(Box<T>.self, from: data)
      return decoded.value
    } catch {
      assertionFailure("OneStore Error : \(error)")
      return nil
    }
  }
  
  @inline(__always)
  private func setValue(newValue: T?) {
    _cached = nil
    
    guard let value = newValue else {
      stack.remove(key: rawStoreKey)
      return
    }
    
    if isPrimitive(type: T.self) {
      stack.userDefaults.set(value, forKey: rawStoreKey)
      return
    }
    
    do {
      let encoded = try encoder.encode(Box(value))
      stack.userDefaults.set(encoded, forKey: rawStoreKey)
    } catch {
      assertionFailure("OneStore Error : \(error)")
    }
  }

  public func reset() {
    value = makeInitialValue()
  }

  private func isPrimitive<ValueType>(type: ValueType.Type) -> Bool {
    switch type {
    case 
    is String.Type,
    is Bool.Type,
    is Int.Type,
    is Int8.Type,
    is Int16.Type,
    is Int32.Type,
    is Int64.Type,
    is UInt.Type,
    is UInt8.Type,
    is UInt16.Type,
    is UInt32.Type,
    is UInt64.Type,
    is Float.Type,
    is Double.Type:
      return true
    default:
      return false
    }
  }
}

