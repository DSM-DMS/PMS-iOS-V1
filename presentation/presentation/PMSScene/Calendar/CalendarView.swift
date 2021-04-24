//
//  CalendarView.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .top) {
                    StoryboardtoUI()
                    
                    VStack {
                        TitleTextView(text: "학사일정")
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, geo.size.height / 1.85)
                        
                        if viewModel.detailCalendar.isEmpty {
                            CalendarTextView(text: "날짜를 클릭하시면 일정을 볼 수 있습니다.")
                                .padding([.leading, .trailing], 30)
                        } else if !viewModel.datesInSchool.contains(viewModel.selectedDate) && !viewModel.datesInHome.contains(viewModel.selectedDate) {
                            CalendarTextView(text: "일정이 없습니다.")
                                .padding([.leading, .trailing], 30)
                        } else {
                            ForEach(self.viewModel.detailCalendar, id: \.self) { cal in
                                CalendarDetailView(text: cal, isHome: cal == "의무귀가", date: viewModel.selectedDate)
                                    .padding([.leading, .trailing], 30)
                            }
                            
                        }
                    }
                    
                }
            }
            VStack {
                Text("")
            }
        }.onAppear { self.viewModel.apply(.onAppear) }
        .edgesIgnoringSafeArea(.all)
    }
}

// struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CalendarView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
//                .previewDisplayName("iPhone XS Max")
//            CalendarView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
//        }
//    }
// }

struct CalendarTextView: View {
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIWidth / 8).shadow(radius: 5)
            VStack(alignment: .center) {
                Text(text)
                    .foregroundColor(GEColor.black)
                
            }.padding()
        }
    }
}

struct CalendarDetailView: View {
    var text: String
    var isHome: Bool
    var date: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(GEColor.gray).frame(height: UIFrame.UIWidth / 8).shadow(radius: 5)
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    Circle().frame(width: 10, height: 10).foregroundColor(isHome ? GEColor.red : GEColor.green)
                    
                    Text(text)
                        .foregroundColor(GEColor.black)
                        .padding(.trailing, 5)
                    
                    Text(String(date.suffix(4)).replacingOccurrences(of: "-", with: " / ").replacingOccurrences(of: "0", with: ""))
                        .foregroundColor(.gray)
                }
                
            }.padding()
        }
    }
}
