//
//  AddTimerAnimator.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/17.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import JRUtils
import RZTransitions
import FXBlurView

let upBlurTag = 100010101
let downBlurTag = 100010102

class AddTimerAnimator: NSObject, RZAnimationControllerProtocol {
    
    var isPositiveAnimation: Bool = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        isPositiveAnimation ?
            positiveAnimation(transitionContext) :
            negativeAnimation(transitionContext)
    }
    
    func positiveAnimation(transitionContext: UIViewControllerContextTransitioning) {
        
        let fc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let tc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let fromView = fc?.view
        let toView = tc?.view
        let container = transitionContext.containerView()
        
        let effect = UIBlurEffect(style: .Light)
        let blurview = UIVisualEffectView(effect: effect)
        blurview.effect = nil
        container?.addSubview(blurview)
        container?.addSubview(toView!)
        
        toView?.frame = fromView!.bounds
        blurview.frame = toView!.frame
        toView?.alpha = 0
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
                                   delay: 0,
                                   options: .CurveEaseOut,
                                   animations: {
                                    
                                    toView?.alpha = 1
                                    blurview.effect = effect
                                    
            },
                                   completion: { (flag) in
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })

    }
    func negativeAnimation(transitionContext: UIViewControllerContextTransitioning) {
        
        let fc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! AddTimerViewController
//        let tc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let fromView = fc.view
//        let toView = tc?.view
        let container = transitionContext.containerView()
        
        container?.addSubview(fromView!)
        let blurview = container?.subviews.filter{$0.isKindOfClass(UIVisualEffectView)}.last as! UIVisualEffectView
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
                                   delay: 0,
                                   options: .CurveEaseOut,
                                   animations: {
                                    
                                    fromView?.alpha = 0
                                    blurview.effect = nil
                                    
                                    container?.insertSubview(fromView, belowSubview: blurview)
                    },
                                   completion: { (flag) in
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}
