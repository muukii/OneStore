// OneStoreValueProtocol.swift
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

public protocol OneStoreValueProtocol {
    
    static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Self?
    func setOneStoreValue(_ userDefaults: UserDefaults, key: String)
}

extension Int: OneStoreValueProtocol {
    
    public static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Int? {
        return (userDefaults.object(forKey: key) as? NSNumber)?.intValue
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {
        userDefaults.set(self, forKey: key)
    }
}

extension Int32: OneStoreValueProtocol {
    
    public static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Int32? {
        return (userDefaults.object(forKey: key) as? NSNumber)?.int32Value
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {
        userDefaults.set(NSNumber(value: self), forKey: key)
    }
}

extension Int64: OneStoreValueProtocol {
    
    public static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Int64? {
        return (userDefaults.object(forKey: key) as? NSNumber)?.int64Value
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {
        userDefaults.set(NSNumber(value: self), forKey: key)
    }
}

extension Float: OneStoreValueProtocol {
    
    public static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Float? {
        return (userDefaults.object(forKey: key) as? NSNumber)?.floatValue
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {
        userDefaults.set(NSNumber(value: self), forKey: key)
    }
}

extension Double: OneStoreValueProtocol {
    
    public static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Double? {
        return (userDefaults.object(forKey: key) as? NSNumber)?.doubleValue
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {
        userDefaults.set(NSNumber(value: self), forKey: key)
    }
}

extension Bool: OneStoreValueProtocol {
    
    public static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Bool? {
        return (userDefaults.object(forKey: key) as? NSNumber)?.boolValue
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {
        userDefaults.set(NSNumber(value: self), forKey: key)
    }
}

// TODO: Object must have NSCoding protocol.
extension NSObject: OneStoreValueProtocol {
    
    public class func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> Self? {
        
        return userDefaults.object(forKey: key)
            .flatMap { $0 as? Data }
            .flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) }
            .flatMap { unsafeBitCast($0, to: self) }
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {        
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: self), forKey: key)
    }
}

extension String: OneStoreValueProtocol {
    
    public static func getOneStoreValue(_ userDefaults: UserDefaults, key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    public func setOneStoreValue(_ userDefaults: UserDefaults, key: String) {
        userDefaults.set(self, forKey: key)
    }
}
