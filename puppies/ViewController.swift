//
//  ViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/20/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import UIKit
import SDWebImage

struct Dog {
    let profile_picture_url: URL
    let name: String
    let favorite_toy: String
    let age: Int
}

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
    
    fileprivate let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sub_views: [UIView] = [self.profileImage, self.nameLabel, self.toyLabel, self.ageLabel]
    
    init(with dog: Dog) {
        print(dog.name)
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.purple
        edgesForExtendedLayout = []
        
        self.profileImage.sd_setImage(with: dog.profile_picture_url)
        self.nameLabel.text = dog.name
        self.toyLabel.text = dog.favorite_toy
        self.ageLabel.text = "\(String(dog.age)) Years in Dog Years!"
        
        for view in sub_views { self.view.addSubview(view) }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: profileImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: profileImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: profileImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: profileImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: toyLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: toyLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: ageLabel, attribute: .top, relatedBy: .equal, toItem: toyLabel, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: ageLabel, attribute: .centerX, relatedBy: .equal, toItem: toyLabel, attribute: .centerX, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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

class ViewController: UITableViewController {
    let dogProfileImages: [URL] = [
        URL(string: "http://r.ddmcdn.com/w_830/s_f/o_1/cx_0/cy_220/cw_1255/ch_1255/APL/uploads/2014/11/dog-breed-selector-australian-shepherd.jpg")!,
        URL(string: "http://cdn-img.health.com/sites/default/files/styles/400x400/public/styles/main/public/dogs-pembroke-welsh-corgi-400x400.jpg?itok=-_QJFWNN")!,
        URL(string: "https://d2wq73xazpk036.cloudfront.net/media/27FB7F0C-9885-42A6-9E0C19C35242B5AC/A5F4E80F-72B7-458F-A40EB676E963E9A9/thul-1e3a85be-5590-5ef4-b332-bc456353498e.jpg?response-content-disposition=inline")!,
        URL(string: "https://s-media-cache-ak0.pinimg.com/originals/b5/fa/82/b5fa82248e3fec6b798333e0043403b6.jpg")!,
        URL(string: "https://s-media-cache-ak0.pinimg.com/736x/63/0f/0e/630f0ef3f6f3126ca11f19f4a9b85243.jpg")!,
    ]
    
    let dogNames: [String] = ["Fido", "Stimpy", "Corny", "Chuck", "Spot"]
    
    let favoriteToys: [String] = ["Tennis Ball", "Stick", "Shoe", "Bone", "Squeaky"]
    
    let dogAge: [Int] = [3, 6, 4, 7, 8]

    lazy var dogs: [Dog] = {
        var dogs = [Dog]()
        for i in 0...4 {
            let dog = Dog(profile_picture_url: self.dogProfileImages[i], name: self.dogNames[i], favorite_toy: self.favoriteToys[i], age: self.dogAge[i])
            dogs.append(dog)
        }
        return dogs
    }()
    
    init() {
        super.init(style: .plain)
        title = "All About Dogs"
        tableView.register(DogCell.self, forCellReuseIdentifier: NSStringFromClass(DogCell.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DogCell.self)) as? DogCell else { return UITableViewCell() }
        cell.dog = dogs[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDog: Dog = dogs[indexPath.row]
        self.navigationController?.pushViewController(DogDetailViewController(with: selectedDog), animated: true)
    }
}
