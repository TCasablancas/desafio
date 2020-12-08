//
//  OwnerView.swift
//  GitRepo
//
//  Created by Thyago on 02/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

class OwnerView: UIView {
    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imgContainer, username])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var imgContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var userPic: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = Theme.default.gray
        view.layer.cornerRadius = 25
        return view
    }()
    
    public lazy var username: UILabel = {
        let label = UILabel()
        label.text = "tcasablancas"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Thin", size: 13.0)
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

extension OwnerView: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(stackView)
        imgContainer.addSubview(userPic)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        imgContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(110)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        userPic.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.center.equalToSuperview()
        }
        
        username.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
}
