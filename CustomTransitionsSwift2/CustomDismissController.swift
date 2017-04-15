//
//  CustomDismissController.swift
//  CustomTransitionsSwift2
//
//  Created by Ildar Zalyalov on 08.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import Foundation
import UIKit

class CustomDismissController: NSObject, UIViewControllerAnimatedTransitioning  {
    var rect: CGRect?
    var imageView: UIImageView?

    override init() {
        super.init()
    }
    
    init(rect: CGRect, imageView: UIImageView) {
        
        self.rect = rect
        self.imageView = imageView
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
       
        
        let containerView = transitionContext.containerView
        
        
        guard let lFromVC = fromViewController as? ViewController2,
            let lToVC = toViewController
            else { return }
        
         let finalFrameForVC = rect!
        
        lToVC.view.alpha = 0.5
        
        containerView.addSubview(lToVC.view)
        containerView.sendSubview(toBack: lToVC.view)
        
        let snapShotView = lFromVC.imageView.snapshotView(afterScreenUpdates: false)
        snapShotView?.frame = lFromVC.imageView.frame
        containerView.addSubview(snapShotView!)
        imageView?.alpha = 0
        
        lFromVC.view.removeFromSuperview()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            
            lToVC.view.alpha = 1.0
            snapShotView?.frame = finalFrameForVC
            
        }) { (finished) in
            self.imageView?.alpha = 1
            snapShotView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
