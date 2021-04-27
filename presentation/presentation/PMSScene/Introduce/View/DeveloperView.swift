//
//  DeveloperView.swift
//  PMS
//
//  Created by jge on 2020/10/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import WaterfallGrid

public struct DeveloperView: View {
    @EnvironmentObject var settings: NavSettings
    @Environment(\.presentationMode) var mode
    @State var offset = CGSize.zero
    var images = [ "Front1", "Front2", "Back1", "Back2", "Android1", "Android2", "iOS1"]
    var fields = ["웹", "웹", "서버", "서버", "안드로이드", "안드로이드", "iOS"]
    var persons = ["강은빈", "이진우", "정지우", "김정빈", "이은별", "김재원", "정고은"]
    
    @ObservedObject var introduceVM: IntroduceViewModel
    
    public init(introduceVM: IntroduceViewModel) {
        self.introduceVM = introduceVM
    }
    
    public var body: some View {
        ZStack {
            ScrollView {
                WaterfallGrid(0...6, id: \.self) { index in
                    DeveloperRectangle(image: images[index], person: persons[index], field: fields[index])
                        .padding(.top)
                }
                .gridStyle(
                    columnsInPortrait: 2,
                    columnsInLandscape: 3,
                    spacing: 8,
                    animation: .easeInOut(duration: 0.5)
                ).padding([.leading, .trailing])
                .padding([.top, .bottom], 10)
            }
            
            if self.introduceVM.isNotInternet {
                checkErrorView(text: "인터넷 연결이 되지 \n 않았습니다.", isAlert: self.$introduceVM.isNotInternet)
            }
        }
        .onAppear {
            self.settings.isNav = true
        }
        .navigationBarTitle("개발자 소개", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
            self.settings.isNav = false
        }) {
            GEImage.navArrow
        })
        .modifier(backDrag(offset: self.$offset))
    }
}

struct DeveloperRectangle: View {
    var image: String
    var person: String
    var field = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(width: UIFrame.UIWidth / 2.6, height: UIFrame.UIHeight / 4.7).shadow(radius: 5)
            VStack(spacing: 15) {
                Image(image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                    .clipShape(Circle())
                
                VStack(spacing: 5) {
                    Text(person)
                        .foregroundColor(GEColor.black)
                        .font(.system(size: 23))
                    
                    Text(field).foregroundColor(.gray).font(.body)
                }
                
            }
        }
    }
}

// struct DeveloperView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            DeveloperView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
//                .previewDisplayName("iPhone XS Max")
//            DeveloperView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
//        }
//    }
// }
