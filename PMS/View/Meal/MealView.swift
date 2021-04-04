//
//  MealView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Kingfisher

struct MealView: View {
    @EnvironmentObject var mealVM: MealViewModel
    var body: some View {
        GeometryReader { _ in
            VStack {
                TitleTextView(text: "급식")
                VStack(spacing: UIFrame.UIHeight / 20) {
                    HStack {
                        Image("leftArrow-1")
                            .onTapGesture {
                                self.mealVM.changeDate(increse: false)
                            }
                        Spacer()
                        Text(self.mealVM.today)
                        Spacer()
                        Image("rightArrow-1").onTapGesture {
                            self.mealVM.changeDate(increse: true)
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            MealRow(now: self.mealVM.nows[0], meal: self.$mealVM.meals[0], picture: self.$mealVM.pictures[0], isPicture: self.$mealVM.isPicture[0])
                                .padding([.leading, .trailing], 5)
                            MealRow(now: self.mealVM.nows[1], meal: self.$mealVM.meals[1], picture: self.$mealVM.pictures[1], isPicture: self.$mealVM.isPicture[1])
                                .padding([.leading, .trailing])
                            MealRow(now: self.mealVM.nows[2], meal: self.$mealVM.meals[2], picture: self.$mealVM.pictures[2], isPicture: self.$mealVM.isPicture[2])
                                .padding([.leading, .trailing], 5)
                        }.padding()
                    }
                }.padding([.leading, .trailing], 10)
            }.padding([.leading, .trailing], 30)
            .onAppear {
                self.mealVM.apply(.getMeal)
            }
            VStack {
                Text("")
            }
        }
        .edgesIgnoringSafeArea(.top)
        
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
                    .frame(height: UIFrame.UIHeight / 17)
                Rectangle().foregroundColor(Color("Blue")).frame(height: 20)
            }
            
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 20))
        }
    }
}

struct FlipView: View {
    @Binding var isPicture: Bool
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
        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("LightGray"))
            .frame(width: UIFrame.UIWidth / 1.5, height: UIFrame.UIHeight / 2).shadow(radius: 5)
    }
}

struct MealRow: View {
    var now: String
    @Binding var meal: String
    @Binding var picture: String
    @Binding var isPicture: Bool
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                ZStack {
                    MealBackgroundView()
                    VStack {
                        if self.isPicture {
                            if picture != "" {
                                NavigationLink(destination: ImageDetailView(url: picture)) {
                                    KFImage(URL(string: picture)!)
                                        .resizable()
                                        .cornerRadius(10)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: UIFrame.UIHeight / 4.5).padding([.leading, .trailing], 10)
                                }
                            } else {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                                    .frame(height: UIFrame.UIHeight / 4.5).padding([.leading, .trailing], 10)
                            }
                        } else {
                            Text(self.meal)
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.1)
                        }
                    }
                    FlipView(isPicture: self.$isPicture)
                }
                BlueTopView(text: self.now)
                
            }
        }
    }
}
