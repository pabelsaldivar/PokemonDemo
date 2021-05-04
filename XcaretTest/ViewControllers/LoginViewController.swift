//
//  LoginViewController.swift
//  XcaretTest
//
//  Created by Jonathan Pabel Saldivar Mendoza on 30/04/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerKeyBoardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterKeyBoardNotifications()
    }
    
    func configureView() {
        continueButton.layer.cornerRadius = 8.0
    }
    
    func validate() -> Result<(user: String, password: String), Error> {
        
        guard let user = userNameTextField.text, !user.isEmpty else {
            return .failure(GenericError.emptyUser)
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            return.failure(GenericError.emptyPasword)
        }
        
        return .success((user: user, password: password))
    }
    
    func login(_ user: String, by password: String) {
        if user != "xcaret" || password != "pabel" {
            show(GenericError.wrongLogin)
        } else {
            AppManager.shared.isUserLogedIn = true
            performSegue(withIdentifier: "DashboardViewControllerNav", sender: nil)
        }
    }
    
    func show(_ error: Error) {
        let title = "Ooh oh! "
        let message = error.localizedDescription
        let settingsActionTitle = "Entendido"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let goToSettings = UIAlertAction(title: settingsActionTitle, style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(goToSettings)
        self.present(alert, animated: true)
    }

    @IBAction func continueButtonTapped(_ sender: Any) {
        switch validate() {
        case .success(let data):
            self.view.endEditing(true)
            login(data.user, by: data.password)
        case .failure(let error):
            show(error)
        }
    }
}

extension LoginViewController {
    private func registerKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = keyboardSize.cgRectValue
        
        let realDistance = keyboardFrame.height
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: realDistance, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.endEditing(true)
        default:
            break
        }
        return true
    }
}
