//
//  SessionRespones.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 30/11/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation


struct Account:Codable{
    let registered: Bool
    let key: String
}

struct Session:Codable {
    let id: String
    let expiration: String
}

struct SessionRespones:Codable{
    let account: Account
    let session: Session
}


