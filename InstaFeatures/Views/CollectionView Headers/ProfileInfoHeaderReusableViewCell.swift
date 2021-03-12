//
//  ProfileInfoHeaderReusableViewCellCollectionReusableView.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 12/03/21.
//

import UIKit

class ProfileInfoHeaderReusableViewCell: UICollectionReusableView {
        static let identifier = "ProfileInfoHeaderReusableViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
