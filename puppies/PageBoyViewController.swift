//
//  PageBoyViewController.swift
//  puppies
//
//  Created by Alex Murphy on 4/29/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import Pageboy

protocol SwipingNavigationDelegate: class {
    func willScroll(to index: Int)
}

class NavigationCell: UICollectionViewCell {
    public var itemTitle: String? {
        didSet {
            self.titleLabel.text = self.itemTitle
        }
    }
    
    override var isSelected: Bool {
        didSet {
            indicatorView.backgroundColor = self.isSelected ? .green : .black
            titleLabel.textColor = self.isSelected ? .green : .white
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.addSubview(titleLabel)
        contentView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: indicatorView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: indicatorView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: indicatorView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 7)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MasterDogViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(NavigationCell.self), for: indexPath) as? NavigationCell else { return UICollectionViewCell() }
        cell.itemTitle = indexPath.row == 0 ? "Collection View" : "Table View"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        masterDogPageViewController.scrollToPage(.at(index: indexPath.row), animated: true)
    }
}


extension MasterDogViewController: SwipingNavigationDelegate {
    func willScroll(to index: Int) {
        self .viewControllerSelectorCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .bottom)
    }
}

class MasterDogViewController: UIViewController {
    
    lazy var viewControllerSelectorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(NavigationCell.self, forCellWithReuseIdentifier: NSStringFromClass(NavigationCell.self))
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var masterDogPageViewController: MasterDogPageViewController = {
        let vc = MasterDogPageViewController()
        vc.swipingDelegate = self
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        edgesForExtendedLayout = []
        title = "All About Dogs"
        view.addSubview(masterDogPageViewController.view)
        view.addSubview(viewControllerSelectorCollectionView)
        masterDogPageViewController.didMove(toParentViewController: self)
        viewControllerSelectorCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: viewControllerSelectorCollectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: viewControllerSelectorCollectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: viewControllerSelectorCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: viewControllerSelectorCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: masterDogPageViewController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: masterDogPageViewController.view, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: masterDogPageViewController.view, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: masterDogPageViewController.view, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MasterDogPageViewController: PageboyViewController {
    
    weak var swipingDelegate: SwipingNavigationDelegate?
    
    public let view_controllers: [UIViewController] = [DogCollectionViewController(), DogTableViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        self.dataSource = self
        self.delegate = self
    }
}

extension MasterDogPageViewController: PageboyViewControllerDataSource, PageboyViewControllerDelegate {
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAtIndex index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        self.swipingDelegate?.willScroll(to: index)
    }
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPosition position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {
     return
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAtIndex index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        return
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReload viewControllers: [UIViewController], currentIndex: PageboyViewController.PageIndex) {
        return
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        return nil
    }

    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        return view_controllers
    }
}
