//
//  ViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/20/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UITableViewController {
    let dogs = DogHelper.allDogs()
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
