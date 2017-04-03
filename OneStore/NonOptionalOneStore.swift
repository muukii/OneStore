//
//  NonOptionalOneStore.swift
//  OneStore
//
//  Created by muukii on 2/28/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation

open class NonOptionalOneStore<T: OneStoreValueProtocol>: OneStoreType {

  public typealias Value = T

  public let source: OneStore<T>
  private let defaultValue: T

  public var storeKey: String {
    return source.storeKey
  }

  public var stack: Stack {
    return source.stack
  }

  public var rawStoreKey: String {
    return source.rawStoreKey
  }

  init(defaultValue: T, source: OneStore<T>) {
    self.source = source
    self.defaultValue = defaultValue
  }

  open var value: T {
    get {
      return source.value ?? defaultValue
    }
    set {
      source.value = newValue
    }
  }
}

extension OneStore {

  open func whenNil(return v: T) -> NonOptionalOneStore<T> {
    return NonOptionalOneStore<T>(defaultValue: v, source: self)
  }
}
