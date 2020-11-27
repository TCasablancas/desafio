//
//  ReposTableView.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

protocol RepositoriesCollectionViewPresentationLogic: class {
    func reload()
}

class RepositoriesCollectionView: UIView {
    weak var interactor: ReposInteractor?
    var viewCell: RepositoriesCollectionViewCell?
    private let cellIdentifier = "cell"
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    lazy var collectionView: UICollectionView = {
        let cell = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        cell.register(RepositoriesCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cell.showsVerticalScrollIndicator = false
        cell.showsHorizontalScrollIndicator = false
        cell.isPagingEnabled = true
        cell.delegate = self
        cell.dataSource = self
        cell.clipsToBounds = true
        cell.backgroundColor = .clear
        return cell
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        return flow
    }()
}

extension RepositoriesCollectionView: RepositoriesCollectionViewCellDelegate {
    func reload() {
//        viewCell.reloadData()
    }
}

extension RepositoriesCollectionView: ViewCode {
    func viewHierarchy() {
        self.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    
}
