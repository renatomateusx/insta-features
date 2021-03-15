//
//  IGPostHeaderViewCell.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 11/03/21.
//

import UIKit

class IGPostHeaderViewCell: UITableViewCell {

    static let identifier = "IGPostHeaderViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    

}
