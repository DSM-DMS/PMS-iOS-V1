//
//  ClubView.swift
//  PMS
//
//  Created by jge on 2020/10/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ClubView: View {
    @ObservedObject var introduceVM = IntroduceViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("자녀의 동아리")
                        NavigationLink(destination: ClubDetailView()) {
                            IntroduceRectangle(isPerson: false, image: "DMS", text: "DMS")
                        }
                    }
                    Spacer()
                }
                
                Divider()
                    .padding([.top, .bottom], 10)
            }.padding([.leading, .trailing], 30)
                .padding(.top, 10)
            
            ForEach(1...10, id: \.self) { _ in
                HStack(spacing: 20) {
                    NavigationLink(destination: ClubDetailView()) {
                        IntroduceRectangle(isPerson: false, image: "DMS", text: "DMS")
                    }
                    NavigationLink(destination: ClubDetailView()) {
                        IntroduceRectangle(isPerson: false, image: "DMS", text: "DMS")
                    }
                }
            }.padding(.bottom, 10)
        }
            .navigationBarTitle("동아리 소개", displayMode: .inline)
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

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClubView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ClubView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct IntroduceRectangle: View {
    var isPerson: Bool
    var image: String
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray")).frame(width: UIFrame.UIWidth / 2 - 40, height: UIFrame.UIHeight / 4.5).shadow(radius: 5)
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
