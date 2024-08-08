//
//  ArrivalInfoView.swift
//  Widget
//
//  Created by gnksbm on 4/13/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import SwiftUI
import WidgetKit
import DesignSystem

@available (iOS 17.0, *)
struct ArrivalInfoView: View {
    var entry: ArrivalInfoProvider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        view.widgetBackground(DesignSystemAsset.logoColor.swiftUIColor)
    }
    
    @ViewBuilder
    var view: some View {
        switch widgetFamily {
        case .systemSmall:
            ArrivalInfoSmallView(entry: entry)
       // case .systemMedium:
           // ArrivalInfoMediumView(entry: entry)
        default:
            EmptyView()
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
struct ArrivalInfoView_Preview: PreviewProvider {
    static var previews: some View {
        ArrivalInfoView(
            entry: ArrivalInfoEntry(
                date: .now,
                configuration: .init(),
                responses: .mock
            )
        )
        .previewContext(
            WidgetPreviewContext(family: .systemSmall)
        )
        ArrivalInfoView(
            entry: ArrivalInfoEntry(
                date: .now,
                configuration: .init(),
                responses: .mock
            )
        )
        .previewContext(
            WidgetPreviewContext(family: .systemMedium)
        )
    }
}
#endif
