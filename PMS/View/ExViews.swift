//
//  ExViews.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct TitleTextView: View {
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .font(.largeTitle)
                .padding(.top, UIFrame.UIHeight / 13)
            Spacer()
        }
        
    }
}

struct ButtonView: View {
    var text: String
    var color: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5).foregroundColor(Color(color))
                .frame(width: UIFrame.UIWidth - 60, height: 50)
                .shadow(color: Color.gray.opacity(0.5), radius: 6, x: 0, y: 3)
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        
    }
}

struct CustomDivider: View {
    var body: some View {
        Color.gray.frame(height: 1)
    }
}

extension Image {
    func template() -> some View {
        self
            .renderingMode(.template)
            .resizable()
   }
}
