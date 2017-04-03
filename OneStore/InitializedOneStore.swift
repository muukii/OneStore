//
//  InitializedOneStore.swift
//  OneStore
//
//  Created by muukii on 3/3/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation

open class InitializedOneStore<T: OneStoreValueProtocol>: OneStoreType {


  public let source: OneStore<T>
  private let initializeValue: T

  public var storeKey: String {
    return source.storeKey
  }

  public var stack: Stack {
    return source.stack
  }

  public var rawStoreKey: String {
    return source.rawStoreKey
  }

  init(initializeValue: T, source: OneStore<T>) {
    self.source = source
    self.initializeValue = initializeValue

    if source.value == nil {
      source.value = initializeValue
    }
  }

  open var value: T {
    get {
      guard let value = source.value else {
        assertionFailure("This feature has broken😭")
        return initializeValue
      }
      return value
    }
    set {
      source.value = newValue
    }
  }
}

extension OneStore {

  open func initialize(value v: T) -> InitializedOneStore<T> {
    return InitializedOneStore<T>(initializeValue: v, source: self)
  }
}
