//
//  BaseView.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

class BaseView: UIView {
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.default.orange
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseView: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    
}
