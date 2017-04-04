// Configuration.swift
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

public final class Stack {

  public let userDefaults: UserDefaults
  public let domain: String

  private(set) public var managedKeys: [String] = []

  public init(userDefaults: UserDefaults = UserDefaults.standard, domain: String) {

    assert(domain.isEmpty == false, "Domain must be not empty")

    self.userDefaults = userDefaults
    self.domain = domain
  }

  // synchronize is deprecated
  public func synchronize() {
    // synchronize is deprecated
    userDefaults.synchronize()
  }

  public func removeManagedKeyObjects() {
    managedKeys.forEach(remove(key: ))
  }

  internal func remove(key: String) {
    userDefaults.removeObject(forKey: key)
    synchronize()
    precondition(userDefaults.object(forKey: key) == nil)
  }

  internal func exists(key: String) -> Bool {
    return userDefaults.dictionaryRepresentation()[key] != nil
  }

  internal func addManagedKey(_ key: String) {
    managedKeys.append(key)
  }
}
