//
//  BaseViewController.swift
//  YogaApp
//
//  Created by Rasheda Babatunde on 9/28/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, SlideMenuDelegate {
    
    
    // Implements SlideMenuDelegate protocol
    func slideMenuViewControllerRequestedWithName(_ viewControllerName: String) {
        
        let topViewController = self.navigationController!.topViewController!
        let destViewController = self.storyboard!.instantiateViewController(withIdentifier: viewControllerName)
        
print("topViewController = \(topViewController.restorationIdentifier)")
print("destViewController = \(destViewController.restorationIdentifier)\n")
        
        // Do not set a new view controller if it's the one that is already set.
        if topViewController.restorationIdentifier! != destViewController.restorationIdentifier! {
            self.navigationController!.setViewControllers([destViewController], animated: true)
        }
    }
    
    func addSlideMenuButtonToNav() {
        
        let slideMenuBtn = UIButton(type: UIButtonType.system)
        slideMenuBtn.setImage(UIImage(named: "menu"), for: UIControlState())
        slideMenuBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        slideMenuBtn.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: slideMenuBtn)
        
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    
    func onSlideMenuButtonPressed(_ sender: UIButton) {
        
        let mainScreen = UIScreen.main
        
        if sender.tag == 1 {
            
            // The MenuViewController has already been slid out - so hide it by sliding it back in!
            
            sender.tag = 0;
            
            if let viewMenuBack = view.subviews.last {
                
print("viewMenuBack = \(viewMenuBack.restorationIdentifier)")
                
                UIView.animate(withDuration: 0.4, animations: {
                    
                    var frameMenu : CGRect = viewMenuBack.frame
                    frameMenu.origin.x = -mainScreen.bounds.size.width
                    viewMenuBack.frame = frameMenu
                    viewMenuBack.layoutIfNeeded()
                    viewMenuBack.backgroundColor = UIColor.clear
                    
                    }, completion: { (finished) -> Void in
                        
                        // Once the MenuViewController has been slid back in - remove it!
                        viewMenuBack.removeFromSuperview()
                        
print("XXXXXXXXXXXXX")
                })
            }
            
            return
        }
        
        // There is no MenuViewController, so create a new MenuViewController add
        // it to the current view and slide it out.
        
        sender.tag = 1
        
        let MenuVC = self.storyboard!.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
        MenuVC.slideMenuBtn = sender
        MenuVC.delegate = self
        self.view.addSubview(MenuVC.view)
        self.addChildViewController(MenuVC)
        MenuVC.view.layoutIfNeeded()
        
        MenuVC.view.frame = CGRect(x: -mainScreen.bounds.size.width, y: 0, width: mainScreen.bounds.size.width, height: mainScreen.bounds.size.height);
        
        UIView.animate(withDuration: 0.4, animations: {
            
            MenuVC.view.frame = CGRect(x: 0, y: 0, width: mainScreen.bounds.size.width, height: mainScreen.bounds.size.height);
            
            }, completion: nil)
    }
}
