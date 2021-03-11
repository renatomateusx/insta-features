//
//  IGFeedViewCellTableViewCell.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 11/03/21.
//

import UIKit

final class IGFeedViewCell: UITableViewCell {
    static let identifier = "IGFeedViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        
    }
    
}
