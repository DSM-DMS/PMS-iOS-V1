//
//  GEColor.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/05.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI

struct GEColor {
    static let gray = Color("Gray")
    static let black = Color("Black")
    static let white = Color("White")
    static let lightGray = Color("LightGray")
    static let green = Color("Green")
    static let red = Color("Red")
    static let blue = Color("Blue")
}

enum GEEColor: String {
    case blue = "Blue"
    case red = "Red"
}

struct GEImage {
    // Image
    
    static let minus = Image("Minus")
    static let circlePlus = Image("CirclePlus")
    static let navArrow = Image("NavArrow")
    static let search = Image(systemName: "magnifyingglass")
    static let checkmark = Image(systemName: "checkmark")
    static let eyeFill = Image(systemName: "eye.fill")
    static let circle = Image(systemName: "circle")
    static let leftArrow = Image("LeftArrow")
    static let rightArrow = Image("RightArrow")
    static let blackLeftArrow = Image("leftArrow-1")
    static let blackRightArrow = Image("rightArrow-1")
    static let download = Image("Download")
    static let clip = Image("Clip")
    static let enter = Image("Enter")
    static let pencil = Image("Pencil")
    static let bottomArrow = Image("BottomArrow")
    static let flip = Image("Flip")
    static let facebook = Image("Facebook")
    static let naver = Image("Naver")
    static let kakaotalk = Image("KakaoTalk")
    static let apple = Image("Apple")
    static let check = Image("check")
    static let pms = Image("PMS")
    static let lock = Image("lock")
    
    // String
    
    static let calendar = "Calendar"
    static let meal = "Meal"
    static let notice = "Notice"
    static let introduce = "Introduce"
    static let mypage = "Mypage"
    static let person = "person"
    static let nicknamePencil = "pencil-1"
}
