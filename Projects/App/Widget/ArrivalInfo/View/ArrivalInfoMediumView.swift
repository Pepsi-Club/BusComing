//
//  ArrivalInfoMediumView.swift
//  Widget
//
//  Created by gnksbm on 4/12/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//
// import SwiftUI
// import WidgetKit
//
// import Domain
//
// Check: Medium Ver은 UI 피드백 반영안했음 
// @available(iOS 17.0, *)
// struct ArrivalInfoMediumView: View {
//    var entry: ArrivalInfoProvider.Entry
//    
//    var url: URL? {
//        var url: URL?
//        if let busStopId = entry.responses.first?.busStopId {
//            url = .init(string: "widget://deeplink?busStop=\(busStopId)")
//        }
//        return url
//    }
//    
//    var body: some View {
//        VStack {
//            switch entry.responses.isEmpty {
//            case true:
//                emptyView
//            case false:
//                arrivalInfoView
//            }
//        }
//        .widgetURL(url)
//    }
//    
//    var emptyView: some View {
//        VStack(alignment: .center) {
//            Text("즐겨찾기를 추가해 도착 정보를 확인하세요")
//                .font(.nanumBold(14))
//                .foregroundColor(.white)
//        }
//    }
//    
//    var arrivalInfoView: some View {
//        VStack(alignment: .leading) {
//            ForEach(
//                entry.responses.prefix(1),
//                id: \.busStopId
//            ) { busStopResponse in
//                HStack(alignment: .top) {
//                    VStack(alignment: .leading) {
//                        Text(busStopResponse.busStopName)
//                            .font(.nanumExtraBold(15))
//                            .lineLimit(1)
//                        Text(busStopResponse.direction)
//                            .font(.nanumRegular(12))
//                            .lineLimit(1)
//                    }
//                    Spacer()
//                    RefreshView(entry: entry)
//                }
//                
//                Spacer()
//                
//                Rectangle()
//                    .frame(height: 0.8)
//                
//                ForEach(
//                    busStopResponse.buses.prefix(2),
//                    id: \.hashValue
//                ) { bus in
//                    HStack {
//                        Text(bus.busName)
//                            .font(.nanumHeavy(23))
//                            .foregroundColor(.green)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        VStack(alignment: .leading) {
//                            if bus.secondArrivalRemaining.isEmpty {
//                                
//                                Spacer()
//                                
//                                Text(bus.firstArrivalState.toString)
//                                    .font(.nanumExtraBold(13))
//                                    .foregroundColor(
//                                        bus.secondArrivalState.toColor)
//                                    .lineLimit(1)
//                                
//                                Spacer()
//                            } else {
//                                Text(bus.firstArrivalState.toString)
//                                    .font(.nanumExtraBold(13))
//                                    .lineLimit(1)
//                                
//                                Text(bus.firstArrivalRemaining)
//                                    .font(.nanumRegular(10))
//                            }
//                        }
//                        .frame(width: 60)
//                        
//                        VStack(alignment: .leading) {
//                            if bus.secondArrivalRemaining.isEmpty {
//                                
//                                Spacer()
//                                
//                                Text(bus.secondArrivalState.toString)
//                                    .font(.nanumExtraBold(13))
//                                    .foregroundColor(
//                                        bus.secondArrivalState.toColor)
//                                    .lineLimit(1)
//                                
//                                Spacer()
//                            } else {
//                                Text(bus.secondArrivalState.toString)
//                                    .font(.nanumExtraBold(13))
//                                    .lineLimit(1)
//                                
//                                Text(bus.secondArrivalRemaining)
//                                    .font(.nanumRegular(10))
//                            }
//                        }
//                        .frame(width: 60)
//                        
//                        Spacer()
//                    }
//                    
//                    if bus == busStopResponse.buses.prefix(2).first {
//                        Rectangle()
//                            .frame(height: 0.6)
//                    }
//                }
//            }
//        }
//        .foregroundColor(.white)
//    }
//}
//
//#if DEBUG
//@available(iOS 17.0, *)
//struct ArrivalInfoMediumView_Preview: PreviewProvider {
//    static var previews: some View {
//        ArrivalInfoMediumView(
//            entry: ArrivalInfoEntry(
//                date: .now,
//                configuration: .init()
//            )
//        )
//        .widgetBackground()
//        .previewContext(
//            WidgetPreviewContext(family: .systemMedium)
//        )
//        ArrivalInfoMediumView(
//            entry: ArrivalInfoEntry(
//                date: .now,
//                configuration: .init(),
//                responses: .mock
//            )
//        )
//        .widgetBackground()
//        .previewContext(
//            WidgetPreviewContext(family: .systemMedium)
//        )
//    }
//}
//#endif
