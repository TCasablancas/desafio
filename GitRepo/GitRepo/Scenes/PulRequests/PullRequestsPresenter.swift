//
//  PullRequestsPresenter.swift
//  GitRepo
//
//  Created by Thyago on 01/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol PullRequestsPresentationLogic: class {
    
}

class PullRequestsPresenter: ReposPresenterPresentationLogic {
    weak var viewController: PullRequestsDisplayLogic?
}
