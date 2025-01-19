//
//  TabBarController.swift
//  PixExplorer
//
//  Created by Sebin Kwon on 1/17/25.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        tabBar.tintColor = .black
    }
    
    func configureTabBarController() {
        let firstNav = UINavigationController(rootViewController: SearchViewController())
        firstNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let secondNav = UINavigationController(rootViewController: TopicViewController())
        secondNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.xyaxis.line"), selectedImage: UIImage(systemName: "chart.xyaxis.line"))
        secondNav.navigationBar.prefersLargeTitles = true
        
        let thirdNav = UINavigationController(rootViewController: ThirdViewController())
        thirdNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "play.rectangle"), selectedImage: UIImage(systemName: "play.rectangle"))
        let fourthNav = UINavigationController(rootViewController: FourthViewController())
        fourthNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart"))
        
        setViewControllers([firstNav, secondNav, thirdNav, fourthNav], animated: true)
    }
    
}
