//
//  TitleView.swift
//  GitRepo
//
//  Created by Thyago on 08/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesome_swift

class TitleView: UIView {
    public var iconName = ""
    
    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, title])
        return stack
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(
            name: FontAwesome(rawValue: iconName) ?? .book,
            style: .solid,
            textColor: Theme.default.description,
            size: CGSize(width: 16, height: 16))
        return image
    }()
    
    public lazy var title: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Roboto-Medium", size: 20.0)
        label.textColor = Theme.default.link
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

extension TitleView: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(20)
        }
        
        icon.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.height.equalToSuperview()
        }
    }
    
    
}
