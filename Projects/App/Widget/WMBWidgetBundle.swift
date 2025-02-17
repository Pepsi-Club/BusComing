//
//  WMBWidgetBundle.swift
//  WidgetExtension
//
//  Created by gnksbm on 4/4/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct WMBWidgetBundle: WidgetBundle {
    var body: some Widget {
        NearByStopWidget()
        if #available(iOS 17, *) {
            ArrivalInfoWidget()
        }
    }
}
