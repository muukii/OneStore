//
//  NonOptionalOneStore.swift
//  OneStore
//
//  Created by muukii on 2/28/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation

open class NonOptionalOneStore<T: OneStoreValueProtocol> {

  private let source: OneStore<T>
  private let defaultValue: T

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
