//
//  DogCollectionViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/23/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

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
    
    lazy var views: [UIView] = [self.dogImage, self.nameLabel]
    
    func setDog(with dog: Dog) {
        dogImage.sd_setImage(with: dog.profile_picture_url)
        nameLabel.text = dog.name
        contentView.backgroundColor = dog.color
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DogCollectionViewController: UIViewController {
    
    let dogs = DogHelper.allDogs()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        view.register(DogCollectionCell.self, forCellWithReuseIdentifier: NSStringFromClass(DogCollectionCell.self))
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.red
        title = "Dog Collection"
        edgesForExtendedLayout = []
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collection, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collection, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collection, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collection, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DogCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(DogCollectionCell.self), for: indexPath) as? DogCollectionCell else { return UICollectionViewCell() }
        cell.setDog(with: dogs[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 15
        return  CGSize(width: width, height: 230)
    }
}

