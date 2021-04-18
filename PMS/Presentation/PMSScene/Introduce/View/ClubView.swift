//
//  ClubView.swift
//  PMS
//
//  Created by jge on 2020/10/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Kingfisher
import WaterfallGrid

struct ClubView: View {
    @ObservedObject var introduceVM = IntroduceViewModel()
    @EnvironmentObject var settings: NavSettings
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("자녀의 동아리")
                            .foregroundColor(Color.gray)
                        NavigationLink(destination: ClubDetailView(name: "DMS").environmentObject(introduceVM)) {
                            IntroduceRectangle(image: "DMS", text: "DMS")
                        }
                    }
                    Spacer()
                }
                
                Divider()
                    .padding([.top, .bottom], 10)
            }.padding([.leading, .trailing], 30)
            .padding(.top, 10)
            
            WaterfallGrid(introduceVM.clubList.clubs, id: \.self) { club in
                NavigationLink(destination: ClubDetailView(name: club.name) .environmentObject(introduceVM)) {
                    IntroduceRectangle(image: club.imageUrl, text: club.name)
                        .padding(.bottom)
                }
            }
            .gridStyle(
                columnsInPortrait: 2,
                columnsInLandscape: 3,
                spacing: 8,
                animation: .easeInOut(duration: 0.5)
            )
            .padding([.leading, .trailing])
        }.onAppear {
            self.settings.isNav = true
            self.introduceVM.apply(.getClubList)
        }
        .accentColor(GEColor.black)
        .navigationBarTitle("동아리 소개", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
            self.settings.isNav = false
        }) {
            Image("NavArrow")
        })
        .modifier(backDrag(offset: self.$offset))
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
    var image: String
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(width: UIFrame.UIWidth / 2.5, height: UIFrame.UIHeight / 4.7).shadow(radius: 5)
            VStack {
                KFImage(URL(string: image.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!.replacingOccurrences(of: "%3A", with: ":")))
                    .resizable()
                    .frame(width: 90, height: 90)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(text)
                    .foregroundColor(GEColor.black)
            }
        }
    }
}
