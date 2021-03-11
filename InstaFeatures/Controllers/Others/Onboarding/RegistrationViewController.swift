//
//  RegistrationViewController.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
       return field
    }()
    private let userEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
       return field
    }()
    
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private  let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        registerButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        userNameField.delegate = self
        userEmailField.delegate = self
        passwordField.delegate = self
        addSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height / 3.0)
        userNameField.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.width - 50, height: 52.0)
        userEmailField.frame = CGRect(x: 25, y: userNameField.bottom + 10, width: view.width - 50, height: 52.0)
        passwordField.frame = CGRect(x: 25, y: userEmailField.bottom + 10, width: view.width - 50, height: 52.0)
        registerButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 52.0)
        configureHeaderView()
     }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 0 else {return}
       
        //Insta Logo
        let imageView = UIImageView(image: UIImage(named: "instaLogo2"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0, y: view.safeAreaInsets.top, width: headerView.width / 2, height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews(){
        view.addSubview(headerView)
        view.addSubview(userNameField)
        view.addSubview(userEmailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
    }
    
    @objc private func didTapCreateAccountButton(){
        passwordField.resignFirstResponder()
        userEmailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        guard let userName = userNameField.text, !userName.isEmpty, let userEmail = userEmailField.text, !userEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {return}
        
        //create account func
        AuthManager.shared.registerNewUser(with: userName, email: userEmail, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    // good to go ahead
                }else{
                    // failed
                }
            }
        }
    }
}


extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            userEmailField.becomeFirstResponder()
        }
        else if textField == userEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapCreateAccountButton()
        }
        return true
    }
}
