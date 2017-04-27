//
//  DogCell.swift
//  puppies
//
//  Created by Alex Murphy on 4/23/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit

class DogCell: UITableViewCell {
    public var dog: Dog? {
        didSet {
            self.profileImage.sd_setImage(with: dog?.profile_picture_url)
            self.nameLabel.text = dog?.name
        }
    }

    fileprivate let profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Fido"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.purple
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: profileImage, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: profileImage, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: profileImage, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0),
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: profileImage, attribute: .right, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
