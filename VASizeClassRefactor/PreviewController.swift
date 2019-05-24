//
//  CollectionViewController.swift
//  VASizeClassRefactor
//
//  Created by TIAA on 20/05/19.
//  Copyright © 2019 TIAA. All rights reserved.
//

import UIKit

class PreviewController: UIViewController {
    
    private var numberOfColumns: Int {
        
        switch UIApplication.shared.keyWindow!.sizeCategory {
        case .extraSmall:
            return 2
        case .small:
            return 3
        case .medium:
            return 4
        case .large:
            return 5
        }
    }
    
    override func loadView() {
        super.loadView()
        self.setupCollectionView()
    }
    
    private let dataSource = CollectionViewDataSource()
    private let layout = UICollectionViewFlowLayout()
    private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.dataSource = self.dataSource
        self.collectionView.delegate = self
        self.view.backgroundColor = UIColor.white
    }
    
    private func setupCollectionView() {
        self.layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
        
        self.collectionView = collectionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupMenuItem()
    }
    
    private func setupMenuItem() {
        let menuItem = UIBarButtonItem(image: UIImage(named: "menu"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(menuTapped_AlwaysShowAsPopOver))
        self.navigationItem.rightBarButtonItem = menuItem
    }
    
    @objc func menuTapped() {
        
        let listViewController = ListViewController()
        switch traitCollection.horizontalSizeClass {
        case .regular:
            listViewController.modalPresentationStyle = .popover
            listViewController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            self.present(listViewController, animated: true, completion: nil)
        default:
            self.navigationController?.pushViewController(listViewController, animated: true)
        }
    }
    
    @objc func menuTapped_AlwaysShowAsPopOver() {
        
        let listViewController = ListViewController()
        listViewController.modalPresentationStyle = .popover
        listViewController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        let presentationController = listViewController.popoverPresentationController
        presentationController?.delegate = self
        
        self.present(listViewController, animated: true, completion: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.layout.invalidateLayout()
    }
}


extension PreviewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected...")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = view.bounds.width - CGFloat(self.numberOfColumns + 1) * self.layout.minimumInteritemSpacing
        let sideLength = floor(availableWidth / CGFloat(self.numberOfColumns))
        return CGSize(width: sideLength, height: sideLength)
    }
}

extension PreviewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
