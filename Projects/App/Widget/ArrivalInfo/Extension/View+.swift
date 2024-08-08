//
//  View+.swift
//  Widget
//
//  Created by gnksbm on 4/12/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import SwiftUI
import DesignSystem

extension View {
    func widgetBackground(
        _ backgroundView: some View = DesignSystemAsset.logoColor.swiftUIColor
    ) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
