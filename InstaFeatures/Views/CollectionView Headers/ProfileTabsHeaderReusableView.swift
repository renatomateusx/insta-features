//
//  ProfileTabsHeaderReusableView.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 12/03/21.
//

import UIKit

class ProfileTabsHeaderReusableView: UICollectionReusableView {
        static let identifier = "ProfileTabsHeaderReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
