//
//  RefreshView.swift
//  WidgetKit
//
//  Created by gnksbm on 4/12/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import SwiftUI

import Core
import WidgetKit

@available(iOS 17.0, *)
struct RefreshView: View {
    var entry: ArrivalInfoProvider.Entry
    
    var body: some View {
        HStack(spacing: 2) {
            Text(
                entry.date.toString(
                    dateFormat: "HH:mm 업데이트"
                )
            )
            .font(.nanumBold(10))
            Button(intent: entry.configuration) {
                Image(systemName: "arrow.clockwise")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
            }
            .buttonStyle(.plain)
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
struct RefreshView_Preview: PreviewProvider {
    static var previews: some View {
        RefreshView(
            entry: .init(
                date: .now,
                configuration: .init(),
                responses: .mock
            )
        )
        .widgetBackground()
        .previewContext(WidgetPreviewContext(family: .systemSmall))
        RefreshView(
            entry: .init(
                date: .now,
                configuration: .init(),
                responses: .mock
            )
        )
        .widgetBackground()
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
#endif
