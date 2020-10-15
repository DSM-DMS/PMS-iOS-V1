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
            VStack {
                TitleTextView(text: "급식")
                VStack(spacing: UIFrame.UIHeight / 20) {
                    MealDateView(date: self.$mealVM.today)
                    VStack {
                        ZStack(alignment: .top) {
                            ZStack {
                                MealBackgroundView()
                                VStack {
                                    if self.mealVM.isPicture {
                                        RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                                            .frame(height: UIFrame.UIHeight / 4.5).padding([.leading, .trailing], 30)
                                    } else {
                                        Text(self.mealVM.meal)
                                            .fontWeight(.medium)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                FlipView(isPicture: self.$mealVM.isPicture)
                            }
                            BlueTopView(text: self.mealVM.now)
                            
                        }
                    }
                    HStack(spacing: 20) {
                        ImageCircle()
                        ImageCircle()
                        ImageCircle()
                    }
                }.padding([.leading, .trailing], 10)
                .highPriorityGesture(DragGesture().onEnded({ value in
                    if value.translation.width > 50 {
                        print("right")
                        self.mealVM.changeMeal(left: false)
                    }
                    if -value.translation.width > 50 {
                        print("left")
                        self.mealVM.changeMeal(left: true)
                        
                    }
                }))
            }.padding([.leading, .trailing], 30)
            VStack {
                Text("")
            }
        }.edgesIgnoringSafeArea(.top)
        
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

struct ImageCircle: View {
    var body: some View {
        Image(systemName: SFSymbolKey.circle.rawValue)
            .resizable()
            .frame(width: 10, height: 10)
    }
}

struct BlueTopView: View {
    var text: String
    var body: some View {
        ZStack {
            VStack(spacing: -10) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Blue"))
                    .frame(height: UIFrame.UIHeight / 15)
                Rectangle().foregroundColor(Color("Blue")).frame(height: 20)
            }
            
            Text(text)
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

struct FlipView: View {
    @Binding isPicture: Bool
    var body: some View {
        VStack {
            Spacer()
            Image("Flip")
                .resizable()
                .frame(width: UIFrame.UIHeight / 23, height: UIFrame.UIHeight / 23)
                .scaledToFill()
                .onTapGesture {
                    withAnimation {
                        self.isPicture.toggle()
                    }
                }
        }.frame(height: UIFrame.UIHeight / 2.4)
    }
}

struct MealBackgroundView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Gray"))
            .frame(height: UIFrame.UIHeight / 2)
    }
}
