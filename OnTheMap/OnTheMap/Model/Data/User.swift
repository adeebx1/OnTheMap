//
//  User.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 06/12/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation

struct User:Codable {
    var firstName:String
    var lastName:String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

