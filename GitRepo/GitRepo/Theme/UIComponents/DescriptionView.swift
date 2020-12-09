//
//  DescriptionView.swift
//  GitRepo
//
//  Created by Thyago on 08/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesome_swift

class DescriptionView: UIView {
    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var thisDescription: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Regular", size: 14.0)
        label.textColor = Theme.default.description
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionView: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(thisDescription)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }
        
        thisDescription.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
    }
    
    
}
