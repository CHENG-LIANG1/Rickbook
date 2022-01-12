//
//  ViewController.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/16.
//

import UIKit
class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        let homeVC = HomeViewController()
        let settingsVC = SettingsViewController()
        let locationVC = LocationViewController()
        homeVC.tabBarItem = UITabBarItem.init(title: "Characters", image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "barItem")!), tag: 0)
        
        homeVC.tabBarItem.selectedImage = UIImage(named: "home.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "barItem")!)
        
        settingsVC.tabBarItem = UITabBarItem.init(title: "Settings", image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "barItem")!), tag: 0)
        settingsVC.tabBarItem.selectedImage = UIImage(named: "gear.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "barItem")!)
        locationVC.tabBarItem = UITabBarItem.init(title: "Locations", image: UIImage(named: "planet")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "barItem")!), tag: 0)
        locationVC.tabBarItem.selectedImage = UIImage(named: "planet.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "barItem")!)
        
        tabBar.unselectedItemTintColor = .white
//        UITabBar.appearance().barTintColor = UIColor(named: "barItem")!
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false
        let selectedColor = UIColor(named: "barItem")
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "barItem")], for: .normal)
        let controllerArray = [homeVC, locationVC,settingsVC]
        self.viewControllers = controllerArray.map{(UINavigationController.init(rootViewController: $0))}
    }
}
