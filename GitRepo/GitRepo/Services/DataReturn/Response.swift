//
//  Response.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

enum ResponseData {
    case success(model: GithubInfo)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
}
