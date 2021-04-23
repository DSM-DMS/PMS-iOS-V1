//
//  Notice.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/22.
//

import Foundation

public struct Notice: Codable, Hashable {
    public var id: Int
    public var date: String
    public var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "upload-date"
        case title
    }
    
    public init(id: Int, date: String, title: String) {
        self.id = id
        self.date = date
        self.title = title
    }
}

public struct DetailNotice: Codable, Hashable {
    public var id: Int
    public var date: String
    public var title: String
    public var body: String
//    public var attach
    public var comment: [Comment]
    
    public init(id: Int, date: String, title: String, body: String, comment: [Comment]) {
        self.id = id
        self.date = date
        self.title = title
        self.body = body
        self.comment = comment
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "upload-date"
        case title
        case body
        case comment
    }
}

public struct Comment: Codable, Hashable {
    public var id: Int
    public var date: String
    public var body: String
    public var user: CommentUser
    public var comment: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "upload-date"
        case body
        case user
        case comment
    }
}

public struct CommentUser: Codable, Hashable {
    public var email: String
    public var name: String
    public var userRole: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case userRole = "user_role"
    }
}
