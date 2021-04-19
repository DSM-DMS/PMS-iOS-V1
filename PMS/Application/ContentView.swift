//
//  TabView.swift
//  PMS
//
//  Created by jge on 2020/10/11.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import presentation

struct ContentView: View {
    let onNav = NavSettings()
//    let maypageVM = MypageViewModel()
    var body: some View {
        Home().environmentObject(onNav).environmentObject(AppDI.shared.mypageDependencies())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
