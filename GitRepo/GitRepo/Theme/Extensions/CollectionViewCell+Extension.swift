//
//  CollectionViewCell+Extension.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    class func Identifier() -> String {
        return "\(self)"
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}

extension UITableViewCell {
    
    class func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
