//
//  CollectionViewController.swift
//  CustomTransitionsSwift2
//
//  Created by Наталья on 09.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {
    
    var customPresentController = CustomPresentController()
    var customDismissController = CustomDismissController()

    let imageArray = ["image1","image1","image1","image1","image1","image1","image1","image1","image1","image1"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let toVC = segue.destination as! ViewController2
            toVC.transitioningDelegate = self
            guard let cellSender = sender as? CustomCollectionViewCell else {
                return
            }
            toVC.image = cellSender.cellImage.image!
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.cellImage.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        let centerInView = cell.convert(cell.cellImage.frame.origin, to: self.view)
        let imageViewRect = CGRect(x: centerInView.x, y: centerInView.y, width: cell.frame.size.width, height: cell.frame.size.height)
        
        customPresentController =  CustomPresentController(rect: imageViewRect, imageView: cell.cellImage)
        self.performSegue(withIdentifier: "segue", sender: cell)
        customDismissController = CustomDismissController(rect: imageViewRect, imageView: cell.cellImage)
    }
    
    
}



extension CollectionViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissController
    }
}
