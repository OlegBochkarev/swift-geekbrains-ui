//
//  AuthViewController.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 02/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInBottomConstraint: NSLayoutConstraint!
    
    private let minBottomConstraint: CGFloat = 150
    
    private let mainSegueIdentifier = "MainSegueIdentifier"
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeyboardEvents()
    }
    
    // MARK: - CONFIGURE
    
    func configure() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        hideKeyboardWhenTappedAround()
        signInBottomConstraint.constant = minBottomConstraint
    }
    
    // MARK: - BUTTON ACTIONS

    @IBAction func signInTappeed(_ sender: Any) {
        guard let login = loginTextField.text,
            let password = passwordTextField.text else {
            return
        }
        if login.isEmpty && password.isEmpty {
            showAlert(title: "Error", message: "fill login and password")
            return
        }
        if login == "login" && password == "password" {
            performSegue(withIdentifier: mainSegueIdentifier, sender: self)
        } else {
            showAlert(title: "Error", message: "Incorrect login or password")
        }
    }
    
    // MARK: - KEYBOARD
    
    private func subscribeKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        if signInBottomConstraint.constant < keyboardHeight {
            signInBottomConstraint.constant = keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        signInBottomConstraint.constant = minBottomConstraint
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - ALERT
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let continueTitle = "Ok"
        let continueAction = UIAlertAction(title: continueTitle,
                                           style: UIAlertAction.Style.cancel) { _ in
                                            
        }
        alertController.addAction(continueAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // only when adding on the end of textfield && it's a space
        if range.location == textField.text?.count && string == " " {
            // ignore replacement string and add your own
            textField.text = (textField.text ?? "") + "\u{00a0}"// \u{00a0} - отображаемый пробел
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signInTappeed(self)
        
        return true
    }
}

