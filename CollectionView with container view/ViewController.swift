//
//  ViewController.swift
//  CollectionView with container view
//
//  Created by Pratik Gavit on 31/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var lastContentOffset: CGFloat = 0.0
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var containerView: UIScrollView!
    
    private lazy var summaryViewController: FirstViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController else {
            fatalError("Unable to Instantiate Summary View Controller")
        }

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    private lazy var sessionsViewController: SecondViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            fatalError("Unable to Instantiate Summary View Controller")
        }

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)
        // Define Constraints
        viewController.view.frame = containerView.frame
           NSLayoutConstraint.activate([
               viewController.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
               viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}





//MARK: collectionView Delegate and Datasource
extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else{fatalError()}
        cell.lblName.text = "Pratik"
    return cell
    }
}

extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        switch index{
        case 0:
            remove(asChildViewController: sessionsViewController)
            add(asChildViewController: summaryViewController)
        case 1:
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: sessionsViewController)
        default:
            print("default")
        }
        }
    }


extension ViewController:UIScrollViewDelegate{
    
    var pageWidth: CGFloat {
        return containerView.bounds.width
    }
     var scrollPercentage: CGFloat {
        if swipeDirection != .right {
            let module = fmod(containerView.contentOffset.x, pageWidth)
            return module == 0.0 ? 1.0 : module / pageWidth
        }
        return 1 - fmod(containerView.contentOffset.x >= 0 ? containerView.contentOffset.x : pageWidth + containerView.contentOffset.x, pageWidth) / pageWidth
    }

     var swipeDirection: SwipeDirection {
        if containerView.contentOffset.x > lastContentOffset {
            return .left
        } else if containerView.contentOffset.x < lastContentOffset {
            return .right
        }
        return .none
    }
    
   
    enum SwipeDirection {
        case left
        case right
        case none
    }

}
