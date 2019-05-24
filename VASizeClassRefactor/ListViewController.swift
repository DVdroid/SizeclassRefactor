//
//  ListViewController.swift
//  VASizeClassRefactor
//
//  Created by TIAA on 20/05/19.
//  Copyright © 2019 TIAA. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    private let dataSource = TableViewDataSource()
    
    override func loadView() {
        super.loadView()
        
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.dataSource = self.dataSource
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 44
        var contentSize = self.preferredContentSize
        contentSize.height = CGFloat(self.dataSource.tableView(self.tableView, numberOfRowsInSection: 0)) * self.tableView.rowHeight
        self.preferredContentSize = contentSize
    }
}
