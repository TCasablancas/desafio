//
//  Fonts.swift
//  GitRepo
//
//  Created by Thyago on 30/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

enum SizeFont {
    case size10
    case size12
    case size14
    case size16
    case size18
    case size20
    case size22
    case size24
    
    var size: CGFloat {
        switch self {
        case .size10:
            return CGFloat(10)
        case .size12:
            return CGFloat(12)
        case .size14:
            return CGFloat(14)
        case .size16:
            return CGFloat(16)
        case .size18:
            return CGFloat(18)
        case .size20:
            return CGFloat(20)
        case .size22:
            return CGFloat(22)
        case .size24:
            return CGFloat(24)
        }
    }
}

public enum Font: String {
    case robotoMedium       = "Roboto-Medium.ttf"
    case robotoRegular      = "Roboto-Regular.ttf"
    case robotoThin         = "Roboto-Thin.ttf"
    case poppinsExtraLight  = "Poppins-ExtraLight.otf"
    case poppinsRegular     = "Poppins-Regular.otf"
    case poppinsBold        = "Poppins-Bold.otf"

    private func scaledFont(font: UIFont) -> UIFont {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: font)
        } else {
            return font
        }
    }
    
    public func font(_ size: CGFloat = 15.0) -> UIFont {
        let value = size * UIScreen.main.bounds.percentFontSize()
        
        switch self {
        case .robotoMedium:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .medium))
        case .robotoRegular:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .regular))
        case .robotoThin:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .thin))
        case .poppinsExtraLight:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .ultraLight))
        case .poppinsRegular:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .regular))
        case .poppinsBold:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .bold))
        }
    }
}

extension CGRect {
    func percentFontSize() -> CGFloat {
        switch self.height {
        case 480.0:
            return CGFloat(0.7)
        case 568.0:
            return CGFloat(0.8)
        case 667.0:
            return CGFloat(0.9)
        case 736.0:
            return CGFloat(1.0)
        default:
            return CGFloat(1.0)
        }
    }
}
