//
//  Introduce.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/05.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

struct ClubList: Codable, Hashable {
    var clubs: [ClubDetail]
}

struct ClubDetail: Codable, Hashable {
    var name: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "club-name"
        case imageUrl = "picture-uri"
    }
}

struct Club: Codable, Hashable {
    var title: String
    var description: String
    var imageUrl: String
    var member: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case imageUrl = "uri"
        case member
    }
}
