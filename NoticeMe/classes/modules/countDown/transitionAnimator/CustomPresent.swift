//
//  CustomPresent.swift
//  SwiftDemo
//
//  Created by Jren on 15/12/24.
//  Copyright © 2015年 jr-wong. All rights reserved.
//

import UIKit

class CustomPresent : NSObject, UIViewControllerAnimatedTransitioning {
    
    override private init() {}
    static let shareInstance = CustomPresent()

    var gestureDriven: UIPercentDrivenInteractiveTransition?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fvc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let tvc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let fv = fvc?.view
        let tv = tvc?.view
        
        let containerView = transitionContext.containerView()
        
        containerView?.addSubview(fv!)
        containerView?.addSubview(tv!)
        
        tv?.frame = transitionContext.finalFrameForViewController(tvc!)
        
        tv?.frame.origin.y += (tv?.frame.size.height)!

        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            
            tv?.frame = transitionContext.finalFrameForViewController(tvc!)
            fv?.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            }) { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                fv?.transform = CGAffineTransformIdentity
                
        }
    }
}

extension CustomPresent : UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return gestureDriven
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}