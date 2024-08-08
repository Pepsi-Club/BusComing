//
//  ArrivalState+.swift
//  Widget
//
//  Created by 유하은 on 4/18/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Domain
import SwiftUI

extension ArrivalState {
    public var toColor: Color {
        switch self {
        case .soon:
                .red
        case .pending:
                .red
        case .finished:
                .red
        case .arrivalTime:
                .white
        }
    }
}
