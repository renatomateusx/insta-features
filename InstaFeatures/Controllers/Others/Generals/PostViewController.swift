//
//  PostViewController.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import UIKit

class PostViewController: UIViewController {

    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        //Registering cells
        tableView.register(IGFeedViewCell.self, forCellReuseIdentifier: IGFeedViewCell.identifier)
        tableView.register(IGPostHeaderViewCell.self, forCellReuseIdentifier: IGPostHeaderViewCell.identifier)
        tableView.register(IGPostActionViewCell.self, forCellReuseIdentifier: IGPostActionViewCell.identifier)
        tableView.register(IGPostGeneralViewCell.self, forCellReuseIdentifier: IGPostGeneralViewCell.identifier)
        
        return tableView
    }()
    
    //MARK: - INIT
    
    init(model: UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels()
    {
        //Mock Data
        guard let userPostModel = self.model else {
            return
        }
        //Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        //Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // 4Comments Only
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "13455\(x)", username: "@NoPainNoGain", text: "Fantastic Post. Congrats!", createdDate: Date(), likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            case .actions(_): return 1
            case .comments(let comments): return comments.count > 4 ? 4 : comments.count
            case .primaryContent(_): return 1
            case .header(_): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostActionViewCell.identifier, for: indexPath) as! IGPostActionViewCell
                return cell
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostGeneralViewCell.identifier, for: indexPath) as! IGPostGeneralViewCell
                return cell
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedViewCell.identifier, for: indexPath) as! IGFeedViewCell
                return cell
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostHeaderViewCell.identifier, for: indexPath) as! IGPostHeaderViewCell
                return cell
                
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
            case .actions(_): return 60
            case .comments(_): return 50
            case .primaryContent(_): return tableView.width
            case .header(_): return 70
        }
    }
    
}
