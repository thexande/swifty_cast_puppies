//
//  DogDetailViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/23/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit

class DogDetailViewController: UIViewController {
    fileprivate let profileImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let toyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sub_views: [UIView] = [self.profileImage, self.toyLabel, self.ageLabel, self.descriptionLabel]
    
    init(with dog: Dog) {
        print(dog.name)
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = dog.color
        edgesForExtendedLayout = []
        
        self.profileImage.sd_setImage(with: dog.profile_picture_url)
        self.nameLabel.text = dog.name
        self.toyLabel.text = "My favorite toy is a \(dog.favorite_toy)"
        self.ageLabel.text = "\(String(dog.age)) Years in Dog Years!"
        self.title = dog.name
        descriptionLabel.text = dog.dog_description
        
        for view in sub_views { self.view.addSubview(view) }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: profileImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: profileImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: profileImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: profileImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            ])
        
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 50),
//            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
//            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: toyLabel, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: toyLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: ageLabel, attribute: .top, relatedBy: .equal, toItem: toyLabel, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: ageLabel, attribute: .centerX, relatedBy: .equal, toItem: toyLabel, attribute: .centerX, multiplier: 1, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -30),
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: ageLabel, attribute: .bottom, multiplier: 1, constant: 20)
        ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
