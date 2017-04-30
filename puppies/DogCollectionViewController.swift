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
import CHTCollectionViewWaterfallLayout



extension UILabel {
    class func height(for string: String, width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.font = font
        label.text = string
        label.numberOfLines = 0
        label.sizeToFit()
        return label.frame.height
    }
}


class DogCollectionViewController: UIViewController {
    
    let dogs = DogHelper.allDogs()
    
    lazy var collection: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.columnCount = 2
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
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

extension DogCollectionViewController: CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(DogCollectionCell.self), for: indexPath) as? DogCollectionCell else { return UICollectionViewCell() }
        cell.setDog(with: dogs[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nav = parent?.navigationController
        
        self.parent?.parent?.navigationController?.pushViewController(DogDetailViewController(with: self.dogs[indexPath.row]), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 15
        let dogDescriptionHeight = UILabel.height(for: self.dogs[indexPath.row].dog_description, width: width, font: UIFont.systemFont(ofSize: 12))
        let height = 10 + (width - 20) + 10 + 36 + 10 + dogDescriptionHeight + 30
        return  CGSize(width: width, height: height)
    }
}

