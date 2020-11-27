//
//  ViewCode.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

protocol ViewCode {
    func setup()
    func viewHierarchy()
    func setupConstraints()
}

extension ViewCode {
    func setup() {
        viewHierarchy()
        setupConstraints()
    }
}
