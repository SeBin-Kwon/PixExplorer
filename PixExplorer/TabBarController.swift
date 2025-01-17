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
    }
    
    func configureTabBarController() {
        let firstNav = UINavigationController(rootViewController: SearchViewController())
        firstNav.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass")?.withTintColor(.gray), selectedImage: UIImage(systemName: "magnifyingglass")?.withTintColor(.black))
        
        let secondNav = UINavigationController(rootViewController: TopicViewController())
        secondNav.tabBarItem = UITabBarItem(title: "토픽", image: UIImage(systemName: "chart.xyaxis.line")?.withTintColor(.gray), selectedImage: UIImage(systemName: "chart.xyaxis.line")?.withTintColor(.black))
        
        setViewControllers([firstNav, secondNav], animated: true)
    }
    
}
