//
//  TextFieldViewController.swift
//  TestingTextField
//
//  Created by waheedCodes on 25/11/2021.
//

import UIKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private(set) var usernameField: UITextField!
    @IBOutlet private(set) var passwordField: UITextField!
    
    // MARK: - Object Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Object Methods
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField === usernameField {
            return !string.contains(" ")
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameField {
            passwordField.becomeFirstResponder()
        } else {
            guard let userName = usernameField.text,
                  let password = passwordField.text else { return false }
            
            passwordField.resignFirstResponder()
            performLogin(username: userName, password: password)
        }
        return false
    }
    
    private func performLogin(username: String, password: String) {
        print(">> Username: \(username)")
        print(">> Password: \(password)")
    }
    
    deinit {
        print(">> ViewController.deinit")
    }
}
