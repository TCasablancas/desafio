//
//  ViewController.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loadingData = false
    var currentPage = 0
    
    let worker = GithubWorker()
    var repository = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getFirstData()
        
        self.view.layer.backgroundColor = UIColor.red.cgColor
    }


}

extension ViewController {
    func getFirstData() {
        self.loadingData = true
        self.worker.loadRepoList(page: self.currentPage) { (result) in
            switch result {
            case .success(let response):
                let data = response.data.items
            case .serverError(let description):
                print("Server error: \(description) \n")
            case .noConnection(let description):
                print("Server error noConnection: \(description) \n")
            case .timeOut(let description):
                print("Server error timeOut: \(description) \n")
            }
        }
    }
}

