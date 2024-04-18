//
//  ArrivalInfoSmallView.swift
//  AppUITests
//
//  Created by gnksbm on 4/4/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import SwiftUI
import WidgetKit
import DesignSystem

import Core
import Domain

@available(iOS 17.0, *)
struct ArrivalInfoSmallView: View {
    var entry: ArrivalInfoProvider.Entry
    
    var url: URL? {
        var url: URL?
        if let busStopId = entry.responses.first?.busStopId {
            url = .init(string: "widget://deeplink?busStop=\(busStopId)")
        }
        return url
    }
    
    var body: some View {
        VStack {
            switch entry.responses.isEmpty {
            case true:
                emptyView
            case false:
                arrivalInfoView
            }
        }
        .widgetURL(url)
    }
    
    var emptyView: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("즐겨찾기를")
            Text("추가하세요")
        }
        .font(.nanumExtraBold(14))
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
    
    var arrivalInfoView: some View {
        VStack(alignment: .trailing, spacing: 9) {
            Spacer()
            ForEach(
                entry.responses.prefix(1),
                id: \.busStopId
            ) { busStopResponse in
                RefreshView(entry: entry)
                HStack {
                    VStack(alignment: .leading) {
                        Text(busStopResponse.busStopName)
                            .font(.nanumExtraBold(15))
                            .lineLimit(1)
                        Text(busStopResponse.direction)
                            .font(.nanumRegular(11))
                            .lineLimit(1)
                    }
                    Spacer()
                }
                ForEach(
                    busStopResponse.buses.prefix(1),
                    id: \.hashValue
                ) { bus in
                    VStack(alignment: .trailing) {
                        Text(bus.busName)
                            .font(.nanumHeavy(22))
                            .foregroundColor(.green)
                        Spacer()
                        VStack(spacing: 6) {
                            HStack {
                                Spacer()
                                Text(bus.firstArrivalState.toString)
                                    .font(.nanumHeavy(14))
                                    .foregroundColor(bus.firstArrivalState.toColor)
                                    .lineLimit(1)
                                Text(bus.firstArrivalRemaining)
                                    .font(.nanumExtraBold(12))
                            }
                            HStack {
                                Spacer()
                                Text(bus.secondArrivalState.toString)
                                    .font(.nanumHeavy(14))
                                    .foregroundColor(bus.secondArrivalState.toColor)
                                    .lineLimit(1)
                                Text(bus.firstArrivalRemaining)
                                    .font(.nanumExtraBold(12))
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

#if DEBUG
@available(iOS 17.0, *)
struct ArrivalInfoSmallView_Preview: PreviewProvider {
    static var previews: some View {
        ArrivalInfoSmallView(
            entry: ArrivalInfoEntry(
                date: .now,
                configuration: .init()
            )
        )
        .widgetBackground()
        .previewContext(
            WidgetPreviewContext(family: .systemSmall)
        )
        ArrivalInfoSmallView(
            entry: ArrivalInfoEntry(
                date: .now,
                configuration: .init(),
                responses: .mock
            )
        )
        .widgetBackground()
        .previewContext(
            WidgetPreviewContext(family: .systemSmall)
        )
    }
}
#endif
