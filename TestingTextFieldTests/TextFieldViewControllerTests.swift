//
//  TextFieldViewControllerTests.swift
//  TextFieldViewControllerTests
//
//  Created by waheedCodes on 25/11/2021.
//

import XCTest
@testable import TestingTextField

class TextFieldViewControllerTests: XCTestCase {
    
    private var sut: TextFieldViewController!
    
    override func setUp() {
        super.setUp()
        sut = makeSUT()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
        sut = nil
        super.tearDown()
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.usernameField, "username field")
        XCTAssertNotNil(sut.passwordField, "password field")
    }
    
    func test_usernameField_attributesShouldBeSet() {
        let textField = sut.usernameField!
        
        XCTAssertEqual(textField.textContentType, .username, "textContentType")
        XCTAssertEqual(textField.autocorrectionType, .no, "autoCorrectionType")
        XCTAssertEqual(textField.returnKeyType, .next, "returnKeyType")
    }
    
    func test_passwordField_attributesShouldBeSet() {
        let passwordField = sut.passwordField!
        
        XCTAssertEqual(passwordField.textContentType, .password, "textContentType")
        XCTAssertEqual(passwordField.returnKeyType, .go, "returnKeyType")
        XCTAssertTrue(passwordField.isSecureTextEntry, "isSecureTextEntry")
    }
    
    func test_textFieldDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.usernameField.delegate, "usernameField")
        XCTAssertNotNil(sut.passwordField.delegate, "passwordField")
    }
    
    func test_shouldChangeCharacters_usernameWithSpaces_shouldPreventChange() {
        let allowChange = shouldChangeCharacters(in: sut.usernameField,
                                                 replacement: "a b")
        XCTAssertEqual(allowChange, false)
    }
    
    func test_shouldChangeCharacters_usernameWithoutSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.usernameField,
                                                 replacement: "abc")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.passwordField,
                                                 replacement: "a b")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithoutSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.passwordField,
                                                 replacement: "abc")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldReturn_withPassword_shouldPerformLogin() {
        sut.usernameField.text = "aUsername"
        sut.passwordField.text = "aPassword"
        
        shouldReturn(in: sut.passwordField)
    }
    
    func test_shouldReturn_withUsername_shouldMoveFocusToPassword() {
        putInViewHierarchy(sut)
        
        shouldReturn(in: sut.usernameField)
        
        XCTAssertTrue(sut.passwordField.isFirstResponder)
    }
    
    func test_shouldReturn_withPassword_shouldDismissKeyboard() {
        putInViewHierarchy(sut)
        sut.passwordField.becomeFirstResponder()
        XCTAssertTrue(sut.passwordField.isFirstResponder, "precondition")
        
        shouldReturn(in: sut.passwordField)
        
        XCTAssertFalse(sut.passwordField.isFirstResponder)
    }
    
    // MARK: - Methods
    
    private func makeSUT() -> TextFieldViewController {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        return storyboard.instantiateViewController(
                identifier: String(
                    describing: TextFieldViewController.self))
    }
}
