//
//  HomeViewController.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleAuthentication()
    }
    
    func handleAuthentication(){
        
        // Check Authentication Status
        if Auth.auth().currentUser == nil {
            // Show Login Screen
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }

}
