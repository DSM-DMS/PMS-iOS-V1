//
//  PMSView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct PMSView: View {
    @EnvironmentObject var settings: LoginSettings
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: UIFrame.UIWidth / 4) {
                Image("PMS")
                VStack(spacing: 30) {
                    NavigationLink(destination: LoginView()) {
                        ButtonView(text: "로그인", color: GEEColor.blue.rawValue)
                    }
                    NavigationLink(destination: SignupView()) {
                        ButtonView(text: "회원가입", color: GEEColor.red.rawValue)
                    }
                }
                Text("로그인 없이 진행하기 >")
                    .foregroundColor(GEColor.blue)
                    .onTapGesture {
                        if UDManager.shared.isFirstView == false {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        self.settings.isFirstView = true
                        UDManager.shared.isFirstView = true
                        UDManager.shared.isLogin = false
                    }
            }
            .navigationBarTitle("PMS", displayMode: .inline)
        }.accentColor(GEColor.black)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PMSView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PMSView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            PMSView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
        
    }
}
