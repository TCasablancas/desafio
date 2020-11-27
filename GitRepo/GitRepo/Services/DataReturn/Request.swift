//
//  Request.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    let alamofireManager: SessionManager = {
        let configure = URLSessionConfiguration.default
        
        configure.timeoutIntervalForRequest = 1000
        configure.timeoutIntervalForResource = 1000
        
        return SessionManager(configuration: configure)
    }()
}
