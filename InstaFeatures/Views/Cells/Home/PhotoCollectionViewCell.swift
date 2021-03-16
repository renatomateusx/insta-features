//
//  PhotoCollectionViewCell.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 12/03/21.
//
import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImage.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(photoImage)
        contentView.clipsToBounds = true
        accessibilityLabel = "User Post Image"
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost){
        let url = model.thumbnailImage
        photoImage.sd_setImage(with: url, completed: nil)
       
    }
    public func configure(debug imageName: String){
        photoImage.image = UIImage(named: "mountain")
    }
    
}
