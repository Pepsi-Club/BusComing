//
//  FavoritesUseCase.swift
//  Domain
//
//  Created by gnksbm on 1/26/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import RxSwift

public protocol FavoritesUseCase {
    func fakeFetchComplete()
    func fetchFirstPage() -> Observable<[BusStopArrivalInfoResponse]>
    func fetchNextPage() -> Observable<[BusStopArrivalInfoResponse]>
}
