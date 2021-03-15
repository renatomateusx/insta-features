//
//  IGPostActionViewCell.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 11/03/21.
//

import UIKit

class IGPostActionViewCell: UITableViewCell {
    static let identifier = "IGPostActionViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemRed
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
