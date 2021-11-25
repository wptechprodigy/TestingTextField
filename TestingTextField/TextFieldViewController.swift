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
}
