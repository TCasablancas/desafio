//
//  CountingItem.swift
//  GitRepo
//
//  Created by Thyago on 02/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesome_swift

class CountingItem: UIView {
    public var iconName = ""
    var iconColor: UIColor?
    
    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, counter, label])
        stack.axis = .horizontal
        return stack
    }()
    
    public lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(
            name: FontAwesome(rawValue: iconName) ?? .star,
            style: .solid,
            textColor: Theme.default.description,
            size: CGSize(width: 12, height: 12))
        return image
    }()
    
    public lazy var counter: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 16.0)
        return label
    }()
    
    public lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = Theme.default.tag
        label.font = UIFont(name: "Roboto-Regular", size: 16.0)
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

extension CountingItem {
    func getIconColor(color: UIColor) -> UIColor {
        return color
    }
}

extension CountingItem: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(stackView)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalToSuperview()
        }
        
        counter.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(10)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(counter.snp.right).offset(5)
            make.height.equalToSuperview()
        }
    }
}
