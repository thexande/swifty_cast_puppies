//
//  PuppiesCollectionViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/23/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import CHTCollectionViewWaterfallLayout

extension UILabel {
    class func height(for string: String, width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.font = font
        label.numberOfLines = 0
        label.text = string
        label.sizeToFit()
        return label.frame.height
    }
}

class DogCollectionCell: UICollectionViewCell {
    let profileImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sub_views: [UIView] = [self.profileImage, self.nameLabel, self.descriptionLabel]
    
    func setDog(with dog: Dog) {
        profileImage.sd_setImage(with: dog.profile_picture_url)
        nameLabel.text = dog.name
        descriptionLabel.text = dog.dog_description
        contentView.backgroundColor = dog.color
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.red
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        for view in sub_views { contentView.addSubview(view) }
        
        let profileImageWidth: CGFloat = contentView.frame.width - 20
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: profileImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: profileImageWidth),
            NSLayoutConstraint(item: profileImage, attribute: .height, relatedBy: .equal, toItem: profileImage, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: profileImage, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: profileImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 10)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PuppiesCollectionViewController: UIViewController {
    let dogs = DogHelper.allDogs()
    
    lazy var collection: UICollectionView = {
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(DogCollectionCell.self, forCellWithReuseIdentifier: NSStringFromClass(DogCollectionCell.self))
        view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collection, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collection, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collection, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collection, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PuppiesCollectionViewController: CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(DogCollectionCell.self), for: indexPath) as? DogCollectionCell else { return UICollectionViewCell() }
        cell.setDog(with: dogs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 15
        let descriptionHeight = UILabel.height(for: dogs[indexPath.row].dog_description, width: width - 20, font: UIFont.systemFont(ofSize: 12))
        let cellHeight = 10 + (width - 20) + 10 + 36 + 10 + descriptionHeight + 10
        return CGSize(width: width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
}
