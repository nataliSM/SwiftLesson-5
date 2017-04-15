//
//  CustomPresentController.swift
//  CustomTransitionsSwift2
//
//  Created by Ildar Zalyalov on 08.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import Foundation
import UIKit
class CustomPresentController: NSObject, UIViewControllerAnimatedTransitioning {
    var rect: CGRect?
    var imageView: UIImageView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    override init() {
        super.init()
    }
    
    init(rect: CGRect, imageView: UIImageView) {
        
        self.rect = rect
        self.imageView = imageView
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        guard let lFromVC = fromViewController,
              let lToVC = toViewController as? ViewController2 else { return }
        let containerView = transitionContext.containerView
        
        lToVC.view.layoutIfNeeded()
        let finalFrame = lToVC.imageView.frame
        let snapshotView = imageView?.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = rect!
        imageView?.alpha = 0
        
        
        containerView.addSubview(snapshotView!)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            lFromVC.view.alpha = 0.0
            
            snapshotView?.frame = finalFrame
        }) { (finished) in
            snapshotView?.removeFromSuperview()
            containerView.addSubview(lToVC.view)
            transitionContext.completeTransition(true)
            lFromVC.view.alpha = 1.0
        }
    }
}
