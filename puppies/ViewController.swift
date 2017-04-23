//
//  ViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/20/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import UIKit
import SDWebImage

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

class PuppiesTableViewController: UITableViewController {
    let dogs = DogHelper.allDogs()
    
    func pressedAllDogs() {
        self.present(UINavigationController(rootViewController: AllDogsViewController()), animated: true, completion: nil)
    }
    
    init() {
        super.init(style: .plain)
        title = "All About Dogs"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All Dogs", style: .plain, target: self, action: #selector(pressedAllDogs))
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
