//
//  ProfileTabsHeaderReusableView.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 12/03/21.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtontab()
}

final class ProfileTabsHeaderReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsHeaderReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
 
    private let gridButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(taggedButton)
        addSubview(gridButton)
        
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapTaggedButton(){
        taggedButton.tintColor = .systemBlue
        gridButton.tintColor = .lightGray
        delegate?.didTapTaggedButtontab()
    }
    
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height / 8
        let gridButtonX = ((width / 2) - size ) / 2
        gridButton.frame = CGRect(x: gridButtonX, y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: gridButtonX + (width/2), y: Constants.padding, width: size, height: size)
    }
}
