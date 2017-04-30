//
//  AllDogsViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/26/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit

class AllDogsViewController: UIPageViewController {
    let dogs = DogHelper.allDogs()
    
    lazy var allDogViewControllers: [DogDetailViewController] = {
        var dogs = [DogDetailViewController]()
        for dog in self.dogs {
            let controller = DogDetailViewController(with: dog)
            dogs.append(controller)
        }
        return dogs
    }()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        delegate = self
        dataSource = self
        edgesForExtendedLayout = []
        setViewControllers([allDogViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AllDogsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DogDetailViewController else { return nil }
        if let index = allDogViewControllers.index(of: viewController) {
            if index > 0  {
                self.title = dogs[index - 1].name
                return allDogViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DogDetailViewController else { return nil }
        if let index = allDogViewControllers.index(of: viewController) {
            if index < allDogViewControllers.count - 1 {
                self.title = dogs[index + 1].name
                return allDogViewControllers[index + 1]
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
