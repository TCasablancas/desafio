//
//  RepoViewCell.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

protocol RepoViewCellDelegate {
    
}

class RepoViewCell: UITableViewCell {
    var delegate: RepoViewCellDelegate?
    var viewController: ViewController?
}
