//
//  HomeViewController.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        //Registering cells
        tableView.register(IGFeedViewCell.self, forCellReuseIdentifier: IGFeedViewCell.identifier)
        tableView.register(IGPostHeaderViewCell.self, forCellReuseIdentifier: IGPostHeaderViewCell.identifier)
        tableView.register(IGPostActionViewCell.self, forCellReuseIdentifier: IGPostActionViewCell.identifier)
        tableView.register(IGPostGeneralViewCell.self, forCellReuseIdentifier: IGPostGeneralViewCell.identifier)
        
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMockModels()
        view.addSubview(tableView)
//        handleAuthentication()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureMockModels(){
        //Mock Data
        let user = User(username: "@therock", bio: "Actor", name: (first: "The", last: "Rock"),
                        birthDate: Date(), gender: .male,
                        counts: UserCount(followers: 100, following: 100, posts: 100),
                        joinDate: Date(),
                        profilePhoto: URL(string: "https://www.google.com/")!
                        )
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
    
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "13455\(x)", username: "@NoPainNoGain", text: "Fantastic Post. Congrats!", createdDate: Date(), likes: []))
        }
    
        for x in 0...10 {
            let model = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                post: PostRenderViewModel(renderType: .primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            
            feedRenderModels.append(model)
        }
    }
    
    private func handleLogOutAuth(){
        do {
            try Auth.auth().signOut()
        }
        catch{
            print("Error when try to logout")
        }
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
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        if subSection == 0 {
            //header
            return 1
        }
        else if subSection == 1 {
            //post
            return 1
        }
        else if subSection == 2 {
            // actions
            return 1
            
        }
        else if subSection == 3 {
            let commentsModel = model.comments
            switch commentsModel.renderType{
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        
        if subSection == 0 {
            switch model.header.renderType {
                case .header(let user):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGPostHeaderViewCell.identifier, for: indexPath) as! IGPostHeaderViewCell
                    cell.configure(with: user)
                    cell.delegate = self
                    return cell
                case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 1 {
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedViewCell.identifier, for: indexPath) as! IGFeedViewCell
                cell.configure(with: post)
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
        }
        else if subSection == 2 {
            let actionModel = model.actions
            switch actionModel.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostActionViewCell.identifier, for: indexPath) as! IGPostActionViewCell
                cell.delegate = self
                cell.configure(with: "")
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 3 {
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostGeneralViewCell.identifier, for: indexPath) as! IGPostGeneralViewCell
                return cell
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 70
        }
        else if subSection == 1 {
            return tableView.width
        }
        else if subSection == 2 {
            return 60
        }
        else if subSection == 3 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}

extension HomeViewController: IGPostHeaderViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func reportPost(){
        print("Post Reported!")
    }
    
    
}

extension HomeViewController: IGPostActionViewCellDelegate {
    func didTapLikeButton() {
        print("Tapped Like Button")
    }
    
    func didTapCommentButton() {
        print("Tapped Comment Button")
    }
    
    func didTapSendButton() {
        print("Tapped Send Button")
    }
    
    
}
