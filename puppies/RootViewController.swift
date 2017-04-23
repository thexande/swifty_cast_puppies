//
//  RootViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/23/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIPageViewController {
    let table = UINavigationController(rootViewController: PuppiesTableViewController())
    let collection = UINavigationController(rootViewController: PuppiesCollectionViewController())
    
    lazy var pages: [UIViewController] = [self.table, self.collection]
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
        delegate = self
        dataSource = self
        self.setViewControllers([table], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.index(of: viewController) {
            if index > 0 {
                return pages[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.index(of: viewController) {
            if index < pages.count - 1 {
                return pages[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
