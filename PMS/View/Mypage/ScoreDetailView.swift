//
//  ScoreDetailView.swift
//  PMS
//
//  Created by jge on 2020/10/08.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ScoreDetailView: View {
    @ObservedObject var MypageVM = MypageViewModel()
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var body: some View {
        ScrollView {
            ForEach(1...10, id: \.self) { _ in 
                ZStack {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray"))
                        .frame(height: UIFrame.UIWidth / 6)
                        .shadow(radius: 5)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("사유")
                            Text("2020/09/21")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("-1")
                    }.padding([.leading, .trailing], 30)
                }.padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 5)
            }.padding([.top, .bottom], 10)
            
        }
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
            .navigationBarTitle("상/벌점 내역", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }) {
                Image("NavArrow")
                    .foregroundColor(.black)
            })
    }
}

struct ScoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScoreDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ScoreDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
