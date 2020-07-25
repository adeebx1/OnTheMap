//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 30/11/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation

struct Udacity: Codable {
    let username: String
    let password: String
}

struct LoginRequest: Codable {
    let udacity: Udacity

}
