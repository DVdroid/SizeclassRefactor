//
//  RootviewController.swift
//  VASizeClassRefactor
//
//  Created by TIAA on 20/05/19.
//  Copyright © 2019 TIAA. All rights reserved.
//

import UIKit

class RootviewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        
        let previewController = PreviewController()
        previewController.title = "Preview"
        let previewNavController = UINavigationController(rootViewController: previewController)
        previewNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        let topRatedViewController = TopRatedViewController()
        let adaptiveContainer = AdaptiveContainer(child: topRatedViewController)
        adaptiveContainer.title = "Top Rated"
        let topRatedNavController = UINavigationController(rootViewController: adaptiveContainer)
        topRatedNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let directorySplitViewController = self.getSplitViewController()
        self.viewControllers = [previewNavController, topRatedNavController, directorySplitViewController]
    }
    
    private func getSplitViewController() -> UISplitViewController {

        let master = DirectoryViewController()
        master.title = "Directory"
        let detail = DetailViewController()
        detail.title = "Directory Detail"
        master.selectionDelegate = detail
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [UINavigationController(rootViewController: master),
                                               UINavigationController(rootViewController: detail)]
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.5
        splitViewController.maximumPrimaryColumnWidth = 400
        splitViewController.delegate = self
        splitViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        return splitViewController
    }
}

extension RootviewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
