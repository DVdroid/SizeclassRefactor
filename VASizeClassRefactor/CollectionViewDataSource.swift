//
//  CollectionViewDataSource.swift
//  VASizeClassRefactor
//
//  Created by Vikash Anand on 21/05/19.
//  Copyright © 2019 TIAA. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        myCell.backgroundColor = UIColor.yellow
        
        return myCell
    }
}
