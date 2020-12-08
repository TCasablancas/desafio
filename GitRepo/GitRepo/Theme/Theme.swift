//
//  Theme.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class Theme {
    struct `default` {
        //Colors
        static let white    = UIColor.white
        static let black    = UIColor.black
        static let gray     = UIColor(hexString: Constants.Colors.Hex.gray)
        static let primary  = UIColor(hexString: Constants.Colors.Hex.primaryGreen)
        static let purple   = UIColor(hexString: Constants.Colors.Hex.primaryPurple)
        static let orange   = UIColor(hexString: Constants.Colors.Hex.primaryOrange)
        static let brown    = UIColor(hexString: Constants.Colors.Hex.primaryBrown)
        static let facebook = UIColor(hexString: Constants.Colors.Hex.fbColor)
        static let border   = UIColor(hexString: Constants.Colors.Hex.lightGray)
        static let description = UIColor(hexString: Constants.Colors.Hex.heavyGray)
        static let tag      = UIColor(hexString: Constants.Colors.Hex.denseGray)
        static let bgCell      = UIColor(hexString: Constants.Colors.Hex.cellGray)
    }
}
