//
//  UIWindow+SizeCategory.swift
//  VASizeClassRefactor
//
//  Created by Vikash Anand on 21/05/19.
//  Copyright © 2019 TIAA. All rights reserved.
//

import UIKit

extension UIWindow {
    
    enum SizeCategory {
        case extraSmall
        case small
        case medium
        case large
    }
    
    var sizeCategory: SizeCategory {
        
        switch self.bounds.width {
        //iPhone SE or smaller
        case 0...320:
            return .extraSmall
        //Upto to the size of iPhone Xs max
        case 321...414:
            return .small
        //Upto the the size of 12.9 iPad pro
        case 415...1366:
            return .medium
        //12.9' iPad pro and larger
        default:
            return .large
        }
    }
}
