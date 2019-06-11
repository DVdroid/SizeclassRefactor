//
//  AdaptiveContainer.swift
//  VASizeClassRefactor
//
//  Created by Vikash Anand on 22/05/19.
//  Copyright © 2019 VA. All rights reserved.
//

import UIKit

class AdaptiveContainer: UIViewController {

    let child: UIViewController
    init(child: UIViewController) {
        self.child = child
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChild(self.child)
        view.addSubview(self.child.view)
        
        NSLayoutConstraint.activate([
            self.child.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.child.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.child.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.child.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
        
        self.child.didMove(toParent: self)
    }
    
    private func updateTraitCollection(withSize size: CGSize) {
        let threshold: CGFloat = 700
        let sizeClass: UIUserInterfaceSizeClass = size.width <= threshold ? .compact : .regular
        let overrideTraitCollection = UITraitCollection(horizontalSizeClass: sizeClass)
        self.setOverrideTraitCollection(overrideTraitCollection, forChild: self.child)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.updateTraitCollection(withSize: self.view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.updateTraitCollection(withSize: size)
    }
}
