//
//  OneStoreType.swift
//  OneStore
//
//  Created by muukii on 4/3/17.
//  Copyright © 2017 muukii. All rights reserved.
//

import Foundation

public protocol OneStoreType {
  associatedtype Value
  var storeKey: String { get }
  var stack: Stack { get }
  var rawStoreKey: String { get }
}
