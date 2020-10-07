//
//  MealView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct MealView: View {
    @ObservedObject var mealVM = MealViewModel()
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 20) {
                TitleTextView(text: "급식")
                MealDateView(date: self.$mealVM.today)
                VStack(alignment: .center) {
                    ZStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray"))
                                .frame(height: UIFrame.UIHeight / 2)
                            Text(self.mealVM.meal)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Blue"))
                            .frame(height: UIFrame.UIHeight / 13)
                            Text(self.mealVM.now)
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        
                    }
                }
                HStack(spacing: 20) {
                    Image(systemName: SFSymbolKey.circle.rawValue)
                        .resizable()
                        .frame(width: 12, height: 12)
                    Image(systemName: SFSymbolKey.circle.rawValue)
                        .resizable()
                        .frame(width: 12, height: 12)
                    Image(systemName: SFSymbolKey.circle.rawValue)
                        .resizable()
                        .frame(width: 12, height: 12)
                }
            }.padding([.leading, .trailing], 30)
            VStack {
                Text("")
            }
        }
        
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MealView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            MealView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

struct MealDateView: View {
    @Binding var date: String
    var body: some View {
        HStack {
            Image("leftArrow-1")
            Spacer()
            Text(date)
            Spacer()
            Image("rightArrow-1")
        }
    }
}
