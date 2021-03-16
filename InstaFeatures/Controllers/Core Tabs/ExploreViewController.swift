//
//  ExploreViewController.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()
    
    private var models = [UserPost]()
    
    private var collectionView: UICollectionView?
    
    private let dimmeView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        configureCollection()
        configureGesture()
        searchBar.delegate = self
      
        buildModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmeView.frame = view.bounds
    }
    
    private func configureLayout()
    {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    private func configureCollection(){
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    private func configureGesture(){
        view.addSubview(dimmeView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmeView.addGestureRecognizer(gesture)
    }
    
    private func buildModels()
    {
        for x in 0...20 {
            let user = User(username: "@therock", bio: "Actor", name: (first: "The", last: "Rock"),
                            birthDate: Date(), gender: .male,
                            counts: UserCount(followers: 100, following: 100, posts: 100),
                            joinDate: Date(),
                            profilePhoto: URL(string: "https://www.google.com/")!
                            )
            
            
            let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following), text: "@therock followed you", user: user)
            
            models.append(post)
        }
        
    }

}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        didCancelSearch()
        guard let text = searchBar.text, !text.isEmpty else { return }
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
        
        configureDimme(false)
    }
    
    private func configureDimme(_ show: Bool){
        if !show {
            dimmeView.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.dimmeView.alpha = 0.4
            }
        }
        else{
            UIView.animate(withDuration: 0.2, animations: {
                self.dimmeView.alpha = 0
            }) { done in
                if done {
                    self.dimmeView.isHidden = true
                }
            }
        }
    }
    
    private func query(_ text: String){
        //Perform search in the back end
    }
    
    @objc private func didCancelSearch(){
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        searchBar.text = nil
        configureDimme(true)
    }
}


extension ExploreViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(debug: "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PostViewController(model: model)
        vc.title = model.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
}

