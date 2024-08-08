//
//  ArrivalInfoWidget.swift
//  Widget
//
//  Created by gnksbm on 4/13/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import WidgetKit
import SwiftUI

@available(iOS 17.0, *)

struct ArrivalInfoWidget: Widget {
    let kind: String = "ArrivalInfo"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ArrivalInfoIntent.self,
            provider: ArrivalInfoProvider()
        ) { entry in
            ArrivalInfoView(
                entry: entry
            )
        }
        .supportedFamilies([
            .systemSmall
            // .systemMedium
        ])
        .configurationDisplayName("즐겨찾기")
        .description("실시간 도착정보를 확인할 수 있어요")
    }
}
