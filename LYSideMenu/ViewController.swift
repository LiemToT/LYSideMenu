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
    var leftViewController: LeftViewController!
    var distance: CGFloat = 0
    
    let FullDistance: CGFloat = 0.8
    var centerOfLeftViewAtBeginning: CGPoint!
    var proportionOfLeftView: CGFloat = 1
    var distanceOfLeftView: CGFloat = 50
    var tap: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = UIScreen.mainScreen().bounds
        view.addSubview(imageView)
        
        tap = UITapGestureRecognizer(target: self, action: Selector("showHome"))
        
        leftViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
        // 适配 4.7 和 5.5 寸屏幕的缩放操作，有偶发性小 bug
//        if Common.screenWidth > 320 {
//            proportionOfLeftView = Common.screenWidth / 320
//            distanceOfLeftView += (Common.screenWidth - 320) * FullDistance / 2
//        }
        leftViewController.view.center = CGPointMake(leftViewController.view.center.x - Common.screenWidth, leftViewController.view.center.y)
        
        // 动画参数初始化
        centerOfLeftViewAtBeginning = leftViewController.view.center
        // 把侧滑菜单视图加入根容器
        self.view.addSubview(leftViewController.view)

        homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        homeViewController.panGesture.addTarget(self, action: Selector("pan:"))
        view.addSubview(homeViewController.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pan(recongnizer: UIPanGestureRecognizer) {
        let x = recongnizer.translationInView(view).x
        let trueDistance = distance + x
        
        if recongnizer.state == UIGestureRecognizerState.Ended {
            if trueDistance > Common.screenWidth / 4 {
                showLeft()
            } else if trueDistance < -Common.screenWidth / 4 {
                showRight()
            } else {
                showHome()
            }
            
            return
        }
        
        recongnizer.view!.center = CGPointMake(view.center.x + trueDistance, view.center.y)
        leftViewController.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + trueDistance + distanceOfLeftView , centerOfLeftViewAtBeginning.y)
    }
    
    func showLeft() {
        homeViewController.view.addGestureRecognizer(tap!)
        distance = Common.screenWidth * FullDistance
        doTheAnimate("left")
    }
    
    func showHome() {
        homeViewController.view.removeGestureRecognizer(tap!)
        distance = 0
        doTheAnimate("home")
    }
    
    func showRight() {
        homeViewController.view.addGestureRecognizer(tap!)
        distance = Common.screenWidth * -FullDistance
        doTheAnimate("right")
    }
    
    func doTheAnimate(showWhat: String) {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.homeViewController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y)
            
            if showWhat == "left" {
                // 移动左侧菜单的中心
                self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + Common.screenWidth, self.leftViewController.view.center.y)
            } else if showWhat == "home" {
                self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x, self.leftViewController.view.center.y)
            }

            }, completion: nil)
        
//        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
//            self.homeViewController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y)
//            
//            if showWhat == "left" {
//                // 移动左侧菜单的中心
//                self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + Common.screenWidth, self.leftViewController.view.center.y)
//            } else if showWhat == "home" {
//                self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x, self.leftViewController.view.center.y)
//            }
//
//            }, completion: nil)
    }
}

