//
//  UnitTestPracticeTests.swift
//  UnitTestPracticeTests
//
//  Created by Julian Arias Maetschl on 23-04-21.
//

import XCTest
@testable import UnitTestPractice

class UnitTestPracticeTests: XCTestCase {

    var sut: PasswordManager!

    override func setUpWithError() throws {
        sut = PasswordManager(validations: [])
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testValidInputPassword() throws {
        // Given
        let password: String = PasswordStubs.completePassword
        // When
        let result = sut.validate(password: password)
        // Then
        XCTAssertTrue(result)
    }

    func testFailIfnotOneUpperCaseCharacter() throws {
        // Given
        sut.validations.append(UppercaseValidation())
        let password: String = PasswordStubs.plainPassword
        // When
        let result = sut.validate(password: password)
        // Then
        XCTAssertFalse(result)
    }

    func testOneUpperCaseCharacter() {
        // Given
        let password: String = PasswordStubs.completePassword
        // When
        let result = sut.validate(password: password)
        // Then
        XCTAssertTrue(result)
    }

    func testNumberOnPassword() {
        // Given
        let password: String = PasswordStubs.numberPassword
        // When
        let result = sut.validate(password: password)
        // Then
        XCTAssertTrue(result)
    }

    func testNumberOnPasswordFail() {
        // Given
        sut.validations.append(NumberValidation())
        let password: String = PasswordStubs.uppercasePassword
        // When
        let result = sut.validate(password: password)
        // Then
        XCTAssertFalse(result)
    }

    func testNumberAndUppercasePassword() {
        // Given
        sut.validations.append(NumberValidation())
        sut.validations.append(UppercaseValidation())
        let password: String = PasswordStubs.completePassword
        // When
        let result = sut.validate(password: password)
        // Then
        XCTAssertTrue(result)
    }

    func testNumberAndUppercasePasswordFails() {
        // Given
        sut.validations.append(NumberValidation())
        sut.validations.append(UppercaseValidation())
        let password: String = PasswordStubs.numberPassword
        // When
        let result = sut.validate(password: password)
        // Then
        XCTAssertFalse(result)
    }

    func testValidationCalledOnManager() {
        // Given
        let validationSpy = ValidationSpy()
        sut.validations.append(validationSpy)
        // When
        sut.validate(password: PasswordStubs.plainPassword)
        // Then
        XCTAssertTrue(validationSpy.isValidationWasCalled)
        XCTAssertEqual(validationSpy.numberOfCalls, 1)
    }

}

struct PasswordStubs {
    static let plainPassword = "value"
    static let numberPassword = "value1"
    static let uppercasePassword = "Value"
    static let completePassword = "Value1"
}

class ValidationSpy: Validation {
    var isValidationWasCalled = false
    var numberOfCalls = 0

    // 1
    func validate(_ password: String) -> Bool {
        isValidationWasCalled = true
        numberOfCalls += 1
        return true
    }
}

class NetworkServiceSpy {
    var callIsCalled = false
    func call() -> String {
        callIsCalled = true
        return ""
    }
}
