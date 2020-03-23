//
//  NonOptionalOneStoreSpec.swift
//  OneStore
//
//  Created by muukii on 2/28/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation
import XCTest

@testable import OneStore

class NonOptionalOneStoreSpec: XCTestCase {

  let stack = Stack.init(domain: "me.muukii.test")

  func testBool() {
    let store = NonOptionalOneStore<Bool>(
      stack: stack,
      key: "me.muukii.bool2",
      makeInitialValue: { true }
    )
    
    store.value = false
    XCTAssertEqual(store.value, false)
    store.value = true
    XCTAssertEqual(store.value, true)
    store.value = false
    XCTAssertEqual(store.value, false)
  }
}
