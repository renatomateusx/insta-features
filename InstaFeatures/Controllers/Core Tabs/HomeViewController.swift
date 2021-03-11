//
//  HomeViewController.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedViewCell.self, forCellReuseIdentifier: IGFeedViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        do {
//            try Auth.auth().signOut()
//        }
//        catch{
//            print("Error when try to logout")
//        }
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedViewCell.identifier, for: indexPath) as! IGFeedViewCell
        return cell
    }
}
