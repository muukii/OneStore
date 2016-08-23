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

public protocol DefaultsValueProtocol {
    
    static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Self?
    func setDefaultsValue(userDefaults: NSUserDefaults, key: String)
}

extension Int: DefaultsValueProtocol {
    
    public static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Int? {
        return (userDefaults.objectForKey(key) as? NSNumber)?.integerValue
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {
        userDefaults.setInteger(self, forKey: key)
    }
}

extension Int32: DefaultsValueProtocol {
    
    public static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Int32? {
        return (userDefaults.objectForKey(key) as? NSNumber)?.intValue
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {
        userDefaults.setObject(NSNumber(int: self), forKey: key)
    }
}

extension Int64: DefaultsValueProtocol {
    
    public static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Int64? {
        return (userDefaults.objectForKey(key) as? NSNumber)?.longLongValue
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {
        userDefaults.setObject(NSNumber(longLong: self), forKey: key)
    }
}

extension Float: DefaultsValueProtocol {
    
    public static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Float? {
        return (userDefaults.objectForKey(key) as? NSNumber)?.floatValue
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {
        userDefaults.setObject(NSNumber(float: self), forKey: key)
    }
}

extension Double: DefaultsValueProtocol {
    
    public static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Double? {
        return (userDefaults.objectForKey(key) as? NSNumber)?.doubleValue
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {
        userDefaults.setObject(NSNumber(double: self), forKey: key)
    }
}

extension Bool: DefaultsValueProtocol {
    
    public static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Bool? {
        return (userDefaults.objectForKey(key) as? NSNumber)?.boolValue
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {
        userDefaults.setObject(NSNumber(bool: self), forKey: key)
    }
}

extension NSObject: DefaultsValueProtocol {
    
    public class func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> Self? {
        
        return userDefaults.objectForKey(key)
            .flatMap { $0 as? NSData }
            .flatMap { NSKeyedUnarchiver.unarchiveObjectWithData($0) }
            .flatMap { unsafeBitCast($0, self) }
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {        
        userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(self), forKey: key)
    }
}

extension String: DefaultsValueProtocol {
    
    public static func getDefaultsValue(userDefaults: NSUserDefaults, key: String) -> String? {
        return userDefaults.stringForKey(key)
    }
    
    public func setDefaultsValue(userDefaults: NSUserDefaults, key: String) {
        userDefaults.setObject(self, forKey: key)
    }
}
