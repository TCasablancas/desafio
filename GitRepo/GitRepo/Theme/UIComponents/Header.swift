//
//  Header.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesome_swift

class Header: UIView {
    lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btnLeft, titleContainer, btnRight])
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var btnLeft: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .bars), for: .normal)
        button.setTitleColor(Theme.default.purple, for: .normal)
        return button
    }()
    
    lazy var btnRight: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .search), for: .normal)
        button.setTitleColor(Theme.default.purple, for: .normal)
        return button
    }()
    
    lazy var titleContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var titleApp: UILabel = {
        let label = UILabel()
        label.text = "gitrepo"
        label.font = UIFont(name: "Poppins-Bold", size: 24.0)
        label.textAlignment = .center
        label.textColor = Theme.default.purple
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

extension Header: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(stackView)
        titleContainer.addSubview(titleApp)
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
        
        titleContainer.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(btnLeft.snp.right)
            make.right.equalTo(btnRight.snp.left)
        }
        
        titleApp.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}
