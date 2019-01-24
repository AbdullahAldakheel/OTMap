//
//  StudentInfo.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 21/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//

import Foundation

struct StudentInfo: Codable {
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var updatedAt: String?
}

extension StudentInfo {
    init(mapString: String, mediaURL: String) {
        self.mapString = mapString
        self.mediaURL = mediaURL
    }
}

enum SLParam: String {
    case createdAt
    case firstName
    case lastName
    case latitude
    case longitude
    case mapString
    case mediaURL
    case objectId
    case uniqueKey
    case updatedAt
}
