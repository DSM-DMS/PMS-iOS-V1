//
//  DeveloperView.swift
//  PMS
//
//  Created by jge on 2020/10/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct DeveloperView: View {
    @ObservedObject var introduceVM = IntroduceViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ScrollView {
            ForEach(1...10, id: \.self) { _ in
                HStack(spacing: 20) {
                    DeveloperRectangle(isPerson: true, image: "TestImage", text: "iOS")
                    DeveloperRectangle(isPerson: true, image: "TestImage", text: "iOS")
                }.padding(.bottom)
            }.padding([.leading, .trailing], 30)
            .padding([.top, .bottom], 10)
        }.navigationBarTitle("개발자 소개", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }) {
                Image("NavArrow")
            })
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                        if abs(self.offset.width) > 0 {
                            self.mode.wrappedValue.dismiss()
                        }
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 0 {
                        self.mode.wrappedValue.dismiss()
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
}

struct DeveloperRectangle: View {
    var isPerson: Bool
    var image: String
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(width: UIFrame.UIWidth / 2 - 40, height: UIFrame.UIHeight / 4.7).shadow(radius: 5)
            VStack(spacing: 15) {
                if isPerson {
                    Image(image)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .scaledToFit()
                        .clipShape(Circle())
                } else {
                    Image(image)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .scaledToFit()
                }
                
                Text(text)
                    .foregroundColor(Color.black.opacity(0.7))
            }
        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DeveloperView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            DeveloperView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
