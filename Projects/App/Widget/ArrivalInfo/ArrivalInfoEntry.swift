//
//  ArrivalInfoEntry.swift
//  AppUITests
//
//  Created by gnksbm on 4/4/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import WidgetKit
import Domain

@available(iOS 17.0, *)
struct ArrivalInfoEntry: TimelineEntry {
    let date: Date
    let configuration: ArrivalInfoIntent
    var responses: [BusStopArrivalInfoResponse]
    
    init(
        date: Date,
        configuration: ArrivalInfoIntent,
        responses: [BusStopArrivalInfoResponse] = []
    ) {
        self.date = date
        self.configuration = configuration
        self.responses = responses
    }
}
