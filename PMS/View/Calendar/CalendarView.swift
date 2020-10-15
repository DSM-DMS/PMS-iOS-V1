//
//  CalendarView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                ZStack(alignment: .top) {
                    StoryboardtoUI()
                    
                    TitleTextView(text: "학사일정")
                        .padding([.leading, .trailing], 30)
                }
            }
            VStack {
                Text("")
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            CalendarView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
