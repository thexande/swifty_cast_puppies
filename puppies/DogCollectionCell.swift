//
//  DogCollectionCell.swift
//  puppies
//
//  Created by Alex Murphy on 4/26/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit

class DogCollectionCell: UICollectionViewCell {
    let dogImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "woot woot"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var views: [UIView] = [self.dogImage, self.nameLabel, self.descriptionLabel]
    
    func setDog(with dog: Dog) {
        dogImage.sd_setImage(with: dog.profile_picture_url)
        nameLabel.text = dog.name
        contentView.backgroundColor = dog.color
        descriptionLabel.text = dog.dog_description
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 7
        contentView.layer.masksToBounds = true
        for view in views { contentView.addSubview(view) }
        contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: dogImage, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: dogImage, attribute: .height, relatedBy: .equal, toItem: dogImage, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dogImage, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dogImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 10)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: dogImage, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -10)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
