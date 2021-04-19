//
//  Introduce.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/05.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct ClubList: Codable, Hashable {
    public var clubs: [ClubDetail]
    
    public init(clubs: [ClubDetail]) {
        self.clubs = clubs
    }
}

public struct ClubDetail: Codable, Hashable {
    public var name: String
    public var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "club-name"
        case imageUrl = "picture-uri"
    }
    
    public init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
}

public struct Club: Codable, Hashable {
    public var title: String
    public var description: String
    public var imageUrl: String
    public var member: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case imageUrl = "uri"
        case member
    }
    
    public init(title: String, description: String, imageUrl: String, member: [String]) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.member = member
    }
}
