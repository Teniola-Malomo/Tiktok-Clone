//
//  TabbarController.swift
//  KD Tiktok-Clone
//
//  Created by Sam Ding on 9/8/20.
//  Copyright © 2020 Kaishan. All rights reserved.
//

import Foundation
import UIKit

class TabBarController:  UITabBarController {

    var homeNavigationController: BaseNavigationController!
    var homeViewController: HomeViewController!
    var profileViewController: ProfileViewController!


    //MARK: - LifeCycles
    override func viewDidLoad(){
        super.viewDidLoad()

        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .white

        homeViewController = HomeViewController()
        homeNavigationController = BaseNavigationController(rootViewController: homeViewController)
        profileViewController = ProfileViewController()

        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        homeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeViewController.tabBarItem.title = "Feed"

        profileViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        profileViewController.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        profileViewController.tabBarItem.title = "Profile"

        viewControllers = [homeNavigationController, profileViewController]
    }


}
