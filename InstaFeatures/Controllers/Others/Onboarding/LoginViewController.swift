//
//  LoginViewController.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    
    private let userNameEmailField: UITextField = {
       return UITextField()
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private  let loginButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private  let termsButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private  let privacyButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private  let createAccountButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addSubViews()
        // Do any additional setup after loading the view.
    }
    
    private func addSubViews(){
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLogginButton(){}
    @objc private func didTapTermsButton(){}
    @objc private func didTapPrivacyButton(){}
    @objc private func didTapCreateAccountButton(){}
    
}
