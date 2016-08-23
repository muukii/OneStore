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

public struct Stack {
    
    public static var defaultStack: Stack = Stack(userDefaults: NSUserDefaults.standardUserDefaults(), namespace: nil)
    
    public let userDefaults: NSUserDefaults
    public let namespace: String
    
    public init(userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults(), namespace: String?) {
        
        self.userDefaults = userDefaults
        self.namespace = "__OneStore__\((namespace ?? "default"))"
    }
    
    // synchronize is deprecated
    public func synchronize() {
        // synchronize is deprecated
        userDefaults.synchronize()
    }
    
    public func removeAllObjectsOnNamespace() {
        
        userDefaults.dictionaryRepresentation().forEach { key, object in
            if key.hasPrefix(namespace) {
                userDefaults.removeObjectForKey(key)
            }
        }
    }
}
