//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 30/11/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation

struct StudentLocation:Codable,Equatable {
        var firstName: String
        var lastName: String
        var latitude: Double
        var longitude: Double
        var mapString: String
        var mediaURL: String
        var uniqueKey: String
        var objectId: String
        var createdAt: String
        var updatedAt: String
    }

