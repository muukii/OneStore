//
//  InitializedOneStoreSpec.swift
//  OneStore
//
//  Created by muukii on 3/3/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation
import XCTest

@testable import OneStore

class InitializedOneStoreSpec: XCTestCase {

  let stack = Stack.init(namespace: "me.muukii.test")

  func testInitialize() {
    let store = OneStore<String>("InitializedOneStoreSpec", stack: stack)
    let i = store.initialize(value: "muukii")

    XCTAssertEqual(i.value, "muukii")
    XCTAssertEqual(store.value, "muukii")
  }
}
