//
//  DefaultRegularAlarmEditingService.swift
//  Data
//
//  Created by gnksbm on 3/13/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import Domain

import RxRelay

public final class DefaultRegularAlarmEditingService
: RegularAlarmEditingService {
    public var managedAlarm = BehaviorRelay<RegularAlarmResponse>(
        value: .init(
            busStopId: "",
            busStopName: "",
            busId: "",
            busName: "",
            time: .now,
            weekday: [],
            adirection: ""
        )
    )
    
    private var currentAlarm: RegularAlarmResponse {
        managedAlarm.value
    }
    
    public init() { }
    
    public func update(
        busStopId: String,
        busStopName: String,
        busId: String,
        busName: String,
        adirection: String
    ) {
        managedAlarm.accept(
            .init(
                requestId: currentAlarm.requestId,
                busStopId: busStopId,
                busStopName: busStopName,
                busId: busId,
                busName: busName,
                time: currentAlarm.time,
                weekday: currentAlarm.weekday,
                adirection: adirection
            )
        )
    }
    
    public func update(time: Date) {
        managedAlarm.accept(
            .init(
                requestId: currentAlarm.requestId,
                busStopId: currentAlarm.busStopId,
                busStopName: currentAlarm.busStopName,
                busId: currentAlarm.busId,
                busName: currentAlarm.busName,
                time: time,
                weekday: currentAlarm.weekday,
                adirection: currentAlarm.adirection
            )
        )
    }
    
    public func update(weekday: [Int]) {
        managedAlarm.accept(
            .init(
                requestId: currentAlarm.requestId,
                busStopId: currentAlarm.busStopId,
                busStopName: currentAlarm.busStopName,
                busId: currentAlarm.busId,
                busName: currentAlarm.busName,
                time: currentAlarm.time,
                weekday: weekday,
                adirection: currentAlarm.adirection
            )
        )
    }
    
    public func update(response: RegularAlarmResponse) {
        managedAlarm.accept(response)
    }
    
    public func resetManagedObject() {
        managedAlarm.accept(
            .init(
                busStopId: "",
                busStopName: "",
                busId: "",
                busName: "",
                time: .now,
                weekday: [],
                adirection: ""
            )
        )
    }
}
