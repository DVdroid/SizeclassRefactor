//
//  DetailView.swift
//  VASizeClassRefactor
//
//  Created by Vikash Anand on 24/05/19.
//  Copyright © 2019 TIAA. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    @IBOutlet var aLabel: UILabel!
    func loadFromNib() -> DetailView? {
        let name = String(describing: type(of: self))
        guard let view = Bundle.main.loadNibNamed(name,
                                                  owner: self,
                                                options: nil)?.first as? DetailView else { return nil }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
