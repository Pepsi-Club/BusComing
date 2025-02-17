//
//  RegularAlarmResponse.swift
//  Domain
//
//  Created by gnksbm on 2/12/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import Core

public struct RegularAlarmResponse: Hashable, CoreDataStorable {
    public let requestId: String
    public let busStopId: String
    public let busStopName: String
    public let busId: String
    public let busName: String
    public let time: Date
    public let weekday: [Int]
    public let adirection: String
    
    public init(
        requestId: String = UUID().uuidString,
        busStopId: String,
        busStopName: String, 
        busId: String, 
        busName: String,
        time: Date,
        weekday: [Int],
        adirection: String
    ) {
        self.requestId = requestId
        self.busStopId = busStopId
        self.busStopName = busStopName
        self.busId = busId
        self.busName = busName
        self.time = time
        self.weekday = weekday as [Int]
        self.adirection = adirection
    }
}

public extension Array<RegularAlarmResponse> {
    /// 버스정류장 ID 중복을 제거 후 리턴
    func filterDuplicatedBusStop() -> Self {
        var uniqueStops = Set<String>()
        return filter { stop in
            uniqueStops.insert(stop.busStopId).inserted
        }
    }
}

public extension RegularAlarmResponse {
    var toAddRequest: AddRegularAlarmRequest {
        .init(
            date: time,
            weekday: weekday,
            busRouteId: busId,
            arsId: busStopId,
            busStopName: busStopName,
            busName: busName,
            adirection: adirection
        )
    }
    
    var toRemoveRequest: RemoveRegularAlarmRequest {
        .init(alarmId: requestId)
    }
}
