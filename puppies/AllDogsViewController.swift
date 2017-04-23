//
//  AllDogsViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/23/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit

class AllDogsViewController: UIPageViewController {
    let dogs: [DogDetailViewController] = {
        let dogs = DogHelper.allDogs()
        var controllers = [DogDetailViewController]()
        for i in 0...dogs.count - 1 {
            controllers.append(DogDetailViewController(with: dogs[i]))
        }
        return controllers
    }()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
        delegate = self
        dataSource = self
        edgesForExtendedLayout = []
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(pressedClose))
        setViewControllers([dogs[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressedClose() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AllDogsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DogDetailViewController else { return nil }
        if let index = dogs.index(of: viewController) {
            if index > 0 {
                return dogs[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DogDetailViewController else { return nil }
        if let index = dogs.index(of: viewController) {
            if index < dogs.count - 1 {
                return dogs[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dogs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
