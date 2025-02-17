//
//  BusStopArrivalInfoResponse.swift
//  Domain
//
//  Created by gnksbm on 1/30/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

public struct BusStopArrivalInfoResponse: Hashable {
    public let generatedDate: Date
    public let busStopId: String
    public let busStopName: String
    public let direction: String
    public var buses: [BusArrivalInfoResponse]
    
    public init(
        generatedDate: Date = .now,
        busStopId: String,
        busStopName: String,
        direction: String,
        buses: [BusArrivalInfoResponse]
    ) {
        self.generatedDate = generatedDate
        self.busStopId = busStopId
        self.busStopName = busStopName
        self.direction = direction
        self.buses = buses
    }
}

public extension BusStopArrivalInfoResponse {
    func replaceTime() -> Self {
        let distance = Int(generatedDate.distance(to: .now))
        return BusStopArrivalInfoResponse(
            generatedDate: generatedDate,
            busStopId: busStopId,
            busStopName: busStopName,
            direction: direction,
            buses: buses.map { busInfo in
                let newFirstArrivalState: ArrivalState
                let newSecondArrivalState: ArrivalState
                switch busInfo.firstArrivalState {
                case .soon, .pending, .finished:
                    newFirstArrivalState = busInfo.firstArrivalState
                case .arrivalTime(let time):
                    newFirstArrivalState = time - distance > 60 ?
                        .arrivalTime(time: time - distance):
                        .soon
                }
                switch busInfo.secondArrivalState {
                case .soon, .pending, .finished:
                    newSecondArrivalState
                    = busInfo.secondArrivalState
                case .arrivalTime(let time):
                    newSecondArrivalState = time - distance > 60 ?
                        .arrivalTime(time: time - distance):
                        .soon
                }
                let firstReaining = busInfo.firstArrivalRemaining
                let secondReaining = busInfo.secondArrivalRemaining
                return BusArrivalInfoResponse(
                    busId: busInfo.busId,
                    busName: busInfo.busName,
                    busType: busInfo.busType.rawValue,
                    nextStation: busInfo.nextStation,
                    firstArrivalState: newFirstArrivalState,
                    firstArrivalRemaining: firstReaining,
                    secondArrivalState: newSecondArrivalState,
                    secondArrivalRemaining: secondReaining,
                    adirection: busInfo.adirection,
                    isFavorites: busInfo.isFavorites,
                    isAlarmOn: busInfo.isAlarmOn
                )
            }
        )
    }
    
    func updateFavoritesStatus(
        favoritesList: [FavoritesBusResponse]
    ) -> Self {
        let favoritesSet = Set(
            favoritesList.map { $0.identifier }
        )
        
        let updatedBuses = buses.map { bus in
            var updatedBus = bus
            let identifier = "\(busStopId)\(bus.busId)\(bus.adirection)"
            updatedBus.isFavorites = favoritesSet.contains(identifier)
            return updatedBus
        }
        return .init(
            generatedDate: generatedDate,
            busStopId: busStopId,
            busStopName: busStopName,
            direction: direction,
            buses: updatedBuses
        )
    }
    
    func filterUnfavoritesBuses() -> Self {
        let filteredBuses = buses.filter { busResponse in
            busResponse.isFavorites
        }
        return BusStopArrivalInfoResponse(
            generatedDate: generatedDate,
            busStopId: busStopId,
            busStopName: busStopName,
            direction: direction,
            buses: filteredBuses
        )
    }
}

public extension Array<BusStopArrivalInfoResponse> {
    func filterUnfavorites(favoritesList: [FavoritesBusResponse]) -> Self {
        updateFavoritesStatus(favoritesList: favoritesList)
        .map { $0.filterUnfavoritesBuses() }
        .filter { !$0.buses.isEmpty }
    }
    
    func updateFavoritesStatus(
        favoritesList: [FavoritesBusResponse]
    ) -> Self {
        let favoritesDic = Dictionary(
            uniqueKeysWithValues: favoritesList.map { favorites in
                (favorites.identifier, true)
            }
        )
        return map { busStop in
            var updatedBuses: [BusArrivalInfoResponse] = busStop.buses
            
            for index in updatedBuses.indices {
                let bus = updatedBuses[index]
                let key = "\(busStop.busStopId)\(bus.busId)\(bus.adirection)"
                if let isFavorites = favoritesDic[key] {
                    updatedBuses[index].isFavorites = isFavorites
                } else {
                    updatedBuses[index].isFavorites = false
                }
            }
            
            return BusStopArrivalInfoResponse(
                generatedDate: busStop.generatedDate,
                busStopId: busStop.busStopId,
                busStopName: busStop.busStopName,
                direction: busStop.direction,
                buses: updatedBuses
            )
        }
    }
}

public struct BusArrivalInfoResponse: Codable, Hashable {
    public let busId: String
    public let busName: String
    public let busType: BusType
    public let nextStation: String
    public let firstArrivalState: ArrivalState
    public let firstArrivalRemaining: String
    public let secondArrivalState: ArrivalState
    public let secondArrivalRemaining: String
    public let adirection: String
    public var isFavorites: Bool
    public var isAlarmOn: Bool
    
    public init(
        busId: String,
        busName: String,
        busType: String,
        nextStation: String,
        firstArrivalState: ArrivalState,
        firstArrivalRemaining: String,
        secondArrivalState: ArrivalState,
        secondArrivalRemaining: String,
        adirection: String,
        isFavorites: Bool,
        isAlarmOn: Bool
    ) {
        self.busId = busId
        self.busName = busName
        self.busType = BusType(rawValue: busType) ?? .common
        self.nextStation = nextStation
        self.firstArrivalState = firstArrivalState
        self.firstArrivalRemaining = firstArrivalRemaining
        self.secondArrivalState = secondArrivalState
        self.secondArrivalRemaining = secondArrivalRemaining
        self.adirection = adirection
        self.isFavorites = isFavorites
        self.isAlarmOn = isAlarmOn
    }
}

public enum ArrivalState: Hashable, Codable {
    case soon, pending, finished, arrivalTime(time: Int)
    
    public var toString: String {
        switch self {
        case .soon:
            return "곧 도착"
        case .pending:
            return "출발대기"
        case .finished:
            return "운행종료"
        case .arrivalTime(let time):
            return "\(time / 60)분후"
        }
    }
}

public enum BusType: String, Codable {
    case common = "0"
    case airport = "1"
    case village = "2"
    case trunkLine = "3"
    case branchLine = "4"
    case circulation = "5"
    case wideArea = "6"
    case incheon = "7"
    case gyeonggi = "8"
    case abolition = "9"
    
    public var toString: String {
        switch self {
        case .common:
            return "공용"
        case .airport:
            return "공항"
        case .village:
            return "마을"
        case .trunkLine:
            return "간선"
        case .branchLine:
            return "지선"
        case .circulation:
            return "순환"
        case .wideArea:
            return "광역"
        case .incheon:
            return "인천"
        case .gyeonggi:
            return "경기"
        case .abolition:
            return "폐지"
        }
    }
}
