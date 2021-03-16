//
//  IGPostHeaderViewCell.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 11/03/21.
//

import UIKit
import SDWebImage

protocol IGPostHeaderViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class IGPostHeaderViewCell: UITableViewCell {

    static let identifier = "IGPostHeaderViewCell"
    
    weak var delegate: IGPostHeaderViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.backgroundColor = nil
        return image
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    @objc private func didTapMoreButton(){
        print("tapped")
        delegate?.didTapMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User){
        usernameLabel.text = model.username
        profileImageView.image = UIImage(systemName: "person.circle")
//        profileImageView.sd_setImage(with: model.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        
        
        profileImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profileImageView.layer.cornerRadius = size / 2
        moreButton.frame = CGRect(x: contentView.width-size-2, y: 2, width: size, height: size)
        usernameLabel.frame = CGRect(x: profileImageView.right + 10, y: 2, width: contentView.width-(size * 2)-15, height: contentView.height-4)
    }
    

}
