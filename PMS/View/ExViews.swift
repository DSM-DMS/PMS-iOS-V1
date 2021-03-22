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

struct Template: ImageModifier {
    func body(image: Image) -> some View {
        image.renderingMode(.template)
            .resizable()
    }
}

protocol ImageModifier {
    /// `Body` is derived from `View`
    associatedtype Body: View

    /// Modify an image by applying any modifications into `some View`
    func body(image: Image) -> Self.Body
}

extension Image {
    func modifier<M>(_ modifier: M) -> some View where M: ImageModifier {
        modifier.body(image: self)
    }
}

struct myPageDrag: ViewModifier {
    @Binding var offset: CGSize
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var settings: NavSettings
    
    func body(content: Content) -> some View {
        return content.gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    if abs(self.offset.width) > 50 {
                        self.mode.wrappedValue.dismiss()
                        self.settings.isNav = false
                    }
            }
            .onEnded { _ in
                if abs(self.offset.width) > 50 {
                    self.mode.wrappedValue.dismiss()
                    self.settings.isNav = false
                } else {
                    self.offset = .zero
                }
            }
        )
    }
}
