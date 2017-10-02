import UIKit
import XCTest
@testable import OneStore

class Tests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  let stack = Stack.init(domain: "me.muukii.test.\(UUID().uuidString)")

  func testInitialValue() {

    let boolStore = OneStore<Bool>(stack: stack, key: "me.muukii.testInitialValue")
    XCTAssert(boolStore.value == nil)
  }

  func testInitialValue2() {

    let boolStore = OneStore<Bool>(stack: stack, key: "me.muukii.testInitialValue2", initialize: false)
    XCTAssert(boolStore.value == false)
  }

  func testRemoveHasInitializedValue() {

    let string = OneStore(stack: stack, key: "me.muukii.testRemove", initialize: "hiroshi")
    XCTAssert(string.value == "hiroshi")
    string.reset()
    XCTAssert(string.exists() == true)
    XCTAssert(string.value == "hiroshi")
    XCTAssert(string.exists() == true)
  }

  func testRemoveWithoutInitializedValue() {

    let string = OneStore<String>(stack: stack, key: "me.muukii.testRemove2")
    string.value = "hiroshi"
    XCTAssert(string.value == "hiroshi")
    string.reset()
    XCTAssert(string.exists() == false)
    XCTAssert(string.value == nil)
    XCTAssert(string.exists() == false)
  }

  func testString() {

    let defaults = OneStore<String>(stack: stack, key: "string.testString")

    let object = "hahahahaha"
    defaults.value = object
    XCTAssert(defaults.value != nil)
    XCTAssertEqual(defaults.value, object)
  }

  func testInt() {

    let defaults = OneStore<Int>(stack: stack, key: "int.testInt")
    let object = 1080
    defaults.value = object
    XCTAssert(defaults.value != nil)
    XCTAssertEqual(defaults.value, object)
  }

  func testInt32() {

    let defaults = OneStore<Int32>(stack: stack, key: "int32.testInt32")
    let object: Int32 = 1080
    defaults.value = object
    XCTAssert(defaults.value != nil)
    XCTAssertEqual(defaults.value, object)
  }

  func testInt64() {

    let defaults = OneStore<Int64>(stack: stack, key: "int64.testInt64")
    let object: Int64 = 1080
    defaults.value = object
    XCTAssert(defaults.value != nil)
    XCTAssertEqual(defaults.value, object)
  }

  func testBool() {

    let defaults = OneStore<Bool>(stack: stack, key: "bool")
    let object = true
    defaults.value = object
    XCTAssert(defaults.value != nil)
    XCTAssertEqual(defaults.value, object)
  }

  func testDouble() {

    let defaults = OneStore<Double>(stack: stack, key: "double")
    let object: Double = 1.2345678923456789
    defaults.value = object
    XCTAssert(defaults.value != nil)
    XCTAssertEqual(defaults.value, object)
  }

  func testFloat() {

    let defaults = OneStore<Float>(stack: stack, key: "float")
    let object: Float = 1.2345678923456789
    defaults.value = object
    XCTAssert(defaults.value != nil)
    XCTAssertEqual(defaults.value, object)
  }

  func testCodable() {

    struct MyModel : Codable {
      let name: String
      let number: Int
    }

    let defaults = OneStore<MyModel>(stack: stack, key: "codable")

    let m = MyModel(name: "muukii", number: 24)
    defaults.value = m

    guard let v = defaults.value else {
      XCTFail()
      return
    }

    XCTAssertEqual(v.name, "muukii")
    XCTAssertEqual(v.number, 24)
  }
}
