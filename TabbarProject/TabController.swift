//
//  TabController.swift
//  TabbarProject
//
//  Created by Ruchira Bandara on 2024-06-23.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabs()
        
        self.tabBar.backgroundColor = .lightGray
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .purple
        
        self.addTopShadowToTabBar()
    }

    private func setupTabs() {
        
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeController(), barColor: .systemRed)
        let history = self.createNav(with: "History", and: UIImage(systemName: "clock"), vc: HistoryController(), barColor: .systemGreen)
        let workout = self.createNav(with: "Workout", and: UIImage(systemName: "person"), vc: WorkoutController(), barColor: .systemBlue, hideTabBar: true)
        let exercise = self.createNav(with: "Exercise", and: UIImage(systemName: "cloud.snow"), vc: ExerciseController(), barColor: .systemYellow)
        
        self.setViewControllers([home, history, workout, exercise], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController, barColor: UIColor, hideTabBar: Bool = false) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + " Controller"
        
        // Add the right bar button item with an action to navigate back to the home view controller
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(navigateToHome))
        
        // Hide the tab bar for this view controller if specified
        if hideTabBar {
            vc.hidesBottomBarWhenPushed = true
        }
        
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = barColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        nav.navigationBar.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        nav.navigationBar.tintColor = .white // Bar button item color
        
        return nav
    }
    
    @objc private func navigateToHome() {
        self.selectedIndex = 0
        if let navController = self.selectedViewController as? UINavigationController {
            navController.popToRootViewController(animated: true)
        }
    }
    
    private func addTopShadowToTabBar() {
        guard let tabBar = self.tabBar as? UITabBar else { return }
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.25
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.masksToBounds = false
    }
}
