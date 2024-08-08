//
//  ArrivalInfoIntent.swift
//  Widget
//
//  Created by gnksbm on 4/12/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import WidgetKit
import AppIntents

import Domain

@available(iOS 17.0, *)
struct ArrivalInfoIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    
    @Parameter(title: "정류장, 버스", optionsProvider: FavoritesOptionProvider())
    var busStop: String
}
