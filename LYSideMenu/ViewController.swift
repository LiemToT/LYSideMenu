//
//  ViewController.swift
//  LYSideMenu
//
//  Created by linyi on 16/6/2.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit

struct Common {
    static let screenWidth = UIScreen.mainScreen().bounds.maxX
    static let screenHeight = UIScreen.mainScreen().bounds.maxY
}

class ViewController: UIViewController {
    var homeViewController: HomeViewController!
    var distance: CGFloat = 0
    
    let FullDistance: CGFloat = 0.78
    let Proportion: CGFloat = 0.77
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = UIScreen.mainScreen().bounds
        view.addSubview(imageView)
        
        homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        view.addSubview(homeViewController.view)
        
        homeViewController.panGesture.addTarget(self, action: Selector("pan:"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pan(recongnizer: UIPanGestureRecognizer) {
        let x = recongnizer.translationInView(view).x
        let trueDistance = distance + x
        
        if recongnizer.state == UIGestureRecognizerState.Ended {
            if trueDistance > Common.screenWidth * (Proportion / 3) {
                showLeft()
            } else if trueDistance < Common.screenWidth * -(Proportion / 3) {
                showRight()
            } else {
                showHome()
            }
            
            return
        }
        
        var proportion: CGFloat = recongnizer.view?.frame.origin.x >= 0 ? -1 : 1
        proportion *= trueDistance / Common.screenWidth
        proportion *= 1 - Proportion
        proportion /= 0.6
        proportion += 1
        
        if proportion <= Proportion {
            return
        }
        
        recongnizer.view!.center = CGPointMake(view.center.x + trueDistance, view.center.y)
        recongnizer.view?.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
    }
    
    func showLeft() {
        distance = view.center.x * (FullDistance + Proportion / 2)
        doTheAnimate(Proportion)
    }
    
    func showHome() {
        distance = 0
        doTheAnimate(1)
    }
    
    func showRight() {
        distance = view.center.x * -(FullDistance + Proportion / 2)
        doTheAnimate(Proportion)
    }
    
    func doTheAnimate(proportion: CGFloat) {
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.homeViewController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y)
            self.homeViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
            }, completion: nil)
    }
}

