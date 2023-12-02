//
//  ViewController.swift
//  LoginApp
//
//  Created by Dmitrii Nazarov on 28.11.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: ~ IBOultets
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var envelopImageView: UIImageView!
    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet var passwordLineView: UIView!
    @IBOutlet var emailLineView: UIView!
    @IBOutlet var lockImageView: UIImageView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    // MARK: ~ Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoLoginButton()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    
    // MARK ~ Properties
    private let activeColor = UIColor(named: "notes") ?? UIColor.gray
    private let errorColor = UIColor(named: "error") ?? UIColor.gray
    private var email: String = "" {
        didSet{
            loginBtn.isUserInteractionEnabled = !(email.isEmpty || password.isEmpty)
            loginBtn.backgroundColor = !(email.isEmpty || password.isEmpty) ? errorColor : .systemGray5
        }
    }
    private var password: String = "" {
        didSet{
            loginBtn.isUserInteractionEnabled = !(email.isEmpty || password.isEmpty)
            loginBtn.backgroundColor = !(email.isEmpty || password.isEmpty) ? errorColor : .systemGray5
        }
    }
    
    private let mockEmail = "abc@gmail.com"
    private let mockPassword = "123456"
    
    
    
    
    

    // MARK ~ IBActions
    @IBAction func signUpBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if email.isEmpty {
            makeErrorField(textField: emailTextField)
        }
        
        if password.isEmpty {
            makeErrorField(textField: passwordTextField)
        }
        
        if email == mockEmail && password == mockPassword {
            performSegue(withIdentifier: "goToHomePage", sender: sender)
        } else {
            let alert = UIAlertController(title: "Error".localized, message:"Wrong password or e-mail".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК".localized, style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
        
        
    }
    
    // MARK: ~ Private methods
    private func setuoLoginButton(){
        loginBtn.layer.shadowColor = activeColor.cgColor
        loginBtn.layer.shadowOffset = CGSize(width: 0, height: 8)
        loginBtn.layer.shadowOpacity = 0.4
        loginBtn.layer.shadowRadius = 8
        
        loginBtn.isUserInteractionEnabled = false
        loginBtn.backgroundColor = .systemGray5
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        guard let text = textField.text?.trimmingCharacters(in:
        .whitespacesAndNewlines),
        !text.isEmpty else {return}
        switch textField{
        case emailTextField:
           let isValidEmail =  check(email: text)
            
            if isValidEmail {
                email = text
                envelopImageView.tintColor = .systemGray5
                emailLineView.backgroundColor = .systemGray5
                
            } else {
                email = ""
               makeErrorField(textField: textField)
            }
        case passwordTextField:
            let isValidPassword = check(password: text)
    
            if isValidPassword {
                password = text
                lockImageView.tintColor = .systemGray5
                passwordLineView.backgroundColor = .systemGray5
            } else {
                password = ""
                makeErrorField(textField: textField)
            }
        default:
            print("unknown textfield")
        }
        
    }
    
    private func check(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func check(password: String) -> Bool {
        return password.count >= 4
    }
    
    private func makeErrorField(textField: UITextField) {
        switch textField{
        case emailTextField:
            envelopImageView.tintColor = errorColor
            emailLineView.backgroundColor = errorColor
        case passwordTextField:
            lockImageView.tintColor = errorColor
            passwordLineView.backgroundColor = errorColor
        default:
            print("unknown text filed")
        }
        
    }
    
}
