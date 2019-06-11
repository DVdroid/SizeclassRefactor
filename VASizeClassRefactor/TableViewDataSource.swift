//
//  TableViewDataSource.swift
//  VASizeClassRefactor
//
//  Created by Vikash Anand on 21/05/19.
//  Copyright © 2019 VA. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var preferredAccessoryType: UITableViewCell.AccessoryType = .none
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath)
        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.text = "Cell\(indexPath.row)"
        cell.accessoryType = self.preferredAccessoryType
        
        return cell
    }
}
