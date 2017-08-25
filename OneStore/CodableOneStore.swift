//
//  CodableOneStore.swift
//  OneStore
//
//  Created by muukii on 8/26/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation

open class CodableOneStore<T: Codable> : OneStoreType {

  public typealias Value = T

  public let storeKey: String
  public let stack: Stack

  public final var rawStoreKey: String {
    return "\(stack.domain).\(storeKey)"
  }

  /// set value on "MainThread" synchronously.
  public var writeOnMainThread: Bool = true

  private let initialValue: T?

  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()

  public init(stack: Stack, key: String, initialValue: T? = nil) {

    precondition(key.isEmpty == false, "key must be not empty")

    self.storeKey = key
    self.stack = stack
    self.initialValue = initialValue
    stack.addManagedKey(rawStoreKey)

    if let initialValue = initialValue {
      do {
        try stack.userDefaults.set(encoder.encode(initialValue), forKey: rawStoreKey)
      } catch {
        assertionFailure("\(error)")
      }
    }
  }

  open var value: T? {
    get {
      do {
        return try stack.userDefaults.data(forKey: rawStoreKey)
          .map {
            try decoder.decode(T.self, from: $0)
        }
      } catch {
        assertionFailure("\(error)")
        return nil
      }
    }
    set {
      guard let value = newValue else {
        stack.remove(key: rawStoreKey)
        return
      }

      do {
        let data = try encoder.encode(value)

        if Thread.isMainThread == false && writeOnMainThread {
          DispatchQueue.main.sync {
            stack.userDefaults.set(data, forKey: rawStoreKey)
          }
        } else {
          stack.userDefaults.set(data, forKey: rawStoreKey)
        }
      } catch {
        assertionFailure("\(error)")
      }
    }
  }
}
