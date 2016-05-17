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

class AddTimerAnimator: NSObject, RZAnimationControllerProtocol {
    
    var isPositiveAnimation: Bool = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let tc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        print("\(fc)   \(tc)   \(fc?.view)")
        
        let fromView = fc?.view
        let toView = tc?.view
        let container = transitionContext.containerView()
        
        if isPositiveAnimation {
            let blurview = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
            container?.addSubview(blurview)
            container?.addSubview(toView!)
            
            toView?.frame = fromView!.bounds
            toView?.jr_height = fromView!.jr_height - 100
            toView?.jr_y = -toView!.jr_height
            
            blurview.frame = toView!.frame
            
            UIView.animateWithDuration(self.transitionDuration(transitionContext),
                                       delay: 0,
                                       options: .CurveEaseOut,
                                       animations: {
                                        
//                                        fromView?.transform = CGAffineTransformMakeScale(0.95, 0.95)
                                        toView?.jr_y = 0
                                        blurview.jr_y = 0
                },
                                       completion: { (flag) in
                                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
            
        } else {
            container?.addSubview(fromView!)
            let blurview = container?.subviews.filter{$0.isKindOfClass(UIVisualEffectView)}.last
            UIView.animateWithDuration(self.transitionDuration(transitionContext),
                                       delay: 0,
                                       options: .CurveEaseOut,
                                       animations: {
                                        
                                        toView?.transform = CGAffineTransformIdentity
                                        fromView?.jr_y = -fromView!.jr_height
                                        blurview?.jr_y = -blurview!.jr_height
                },
                                       completion: { (flag) in
                                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
            
        }
    }
}
