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

class NonOptionalOneStore: XCTestCase {

  let stack = Stack.init(namespace: "me.muukii.test")

  func testBool() {
    let store = OneStore<Bool>("me.muukii.bool2", stack: stack).whenNil(return: true)
    XCTAssertEqual(store.value, true)
  }
}
