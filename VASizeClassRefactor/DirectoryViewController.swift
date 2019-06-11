//
//  DirectoryViewController.swift
//  VASizeClassRefactor
//
//  Created by Vikash Anand on 20/05/19.
//  Copyright © 2019 VA. All rights reserved.
//

import UIKit

protocol PresentDetailViewOnSelectionProtocol: NSObject {
    func tableView(_ tableView: UITableView, selectedString string: String)
}

class DirectoryViewController: UITableViewController {

    private let dataSource = TableViewDataSource()
    weak var selectionDelegate: PresentDetailViewOnSelectionProtocol?
    private lazy var detailViewController: DetailViewController = {
        let detailViewController = DetailViewController()
        return detailViewController
    }()
    
    override func loadView() {
        super.loadView()
        
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.dataSource = self.dataSource
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    var preferredAccessoryType: UITableViewCell.AccessoryType {
        if self.splitViewController?.isCollapsed == true {
            return .disclosureIndicator
        }
        return .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 44
        var contentSize = self.preferredContentSize
        contentSize.height = CGFloat(self.dataSource.tableView(self.tableView, numberOfRowsInSection: 0)) * self.tableView.rowHeight
        self.preferredContentSize = contentSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataSource.preferredAccessoryType = self.preferredAccessoryType
        if let text = tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text {
            self.selectionDelegate?.tableView(self.tableView, selectedString:text)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.splitViewController?.isCollapsed == true {
            self.selectionDelegate = self.detailViewController
            if let text = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                self.selectionDelegate?.tableView(self.tableView, selectedString:text)
            }
            self.splitViewController?.showDetailViewController(self.detailViewController, sender: nil)
        } else {
            if let text = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                self.selectionDelegate?.tableView(self.tableView, selectedString:text)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil, completion: { [weak self] _ in
            
            if let self = self {
                self.tableView.visibleCells.forEach({
                    $0.accessoryType = self.preferredAccessoryType
                })
            }
        })
    }
}
