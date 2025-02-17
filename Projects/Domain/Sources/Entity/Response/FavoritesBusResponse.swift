//
//  FavoritesBusResponse.swift
//  Domain
//
//  Created by gnksbm on 4/16/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import Core

public struct FavoritesBusResponse: CoreDataStorable, Equatable {
    public let identifier: String
    public let busStopId: String
    public let busStopName: String
    public let busId: String
    public let busName: String
    public let adirection: String
    
    public init(
        busStopId: String,
        busStopName: String,
        busId: String,
        busName: String,
        adirection: String
    ) {
        self.identifier = busStopId + busId + adirection
        self.busStopId = busStopId
        self.busStopName = busStopName
        self.busId = busId
        self.busName = busName
        self.adirection = adirection
    }
}

public extension Array<FavoritesBusResponse> {
    var toBusStopIds: [String] {
        map { $0.busStopId }
            .removeDuplicated()
            .sorted { $0 < $1 }
    }
}
