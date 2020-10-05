//
//  ContentView.swift
//  PMS
//
//  Created by jge on 2020/09/30.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            StoryboardtoUI()
                .tabItem {
                    VStack {
                        if selection == 0 {
                            Image("Calendar.fill")
                        } else {
                            Image("Calendar")
                        }
                        Text("일정")
                        .foregroundColor(Color("Blue"))
                    }
            }.tag(0)
            MealView()
                .tabItem {
                    Image("Meal")
                    Text("급식")
            }.tag(1)
            NoticeView()
                .tabItem {
                    Image("Notice")
                    Text("공지")
            }.tag(2)
            IntroduceView()
                .tabItem {
                    Image("Introduce")
                    Text("소개")
            }.tag(3)
            MypageView()
                .tabItem {
                    Image("Mypage")
                    Text("내정보")
            }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIImage {
class func colorForNavBar(color: UIColor) -> UIImage {
    //let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)

    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1.0, height: 1.0))

    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()

    context!.setFillColor(color.cgColor)
    context!.fill(rect)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

     return image!
    }
}
