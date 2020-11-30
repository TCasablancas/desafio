//
//  Header.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

class Header: UIView {
    lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btnLeft, imgContainer, btnRight])
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var btnLeft: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.default.black
        return button
    }()
    
    lazy var btnRight: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var imgContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
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

extension Header: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(stackView)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        btnLeft.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        btnRight.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
}
