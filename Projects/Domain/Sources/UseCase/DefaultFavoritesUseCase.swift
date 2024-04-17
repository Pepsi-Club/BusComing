//
//  DefaultFavoritesUseCase.swift
//  Domain
//
//  Created by gnksbm on 1/26/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

public final class DefaultFavoritesUseCase: FavoritesUseCase {
    private let busStopArrivalInfoRepository: BusStopArrivalInfoRepository
    private let favoritesRepository: FavoritesRepository
    
    public let busStopArrivalInfoResponse 
    = BehaviorSubject<[BusStopArrivalInfoResponse]>(value: [])
    private let disposeBag = DisposeBag()
    
    public init(
        busStopArrivalInfoRepository: BusStopArrivalInfoRepository,
        favoritesRepository: FavoritesRepository
    ) {
        self.busStopArrivalInfoRepository = busStopArrivalInfoRepository
        self.favoritesRepository = favoritesRepository
        bindFavorites()
    }
    
    public func fetchFavoritesArrivals() {
        favoritesRepository.favorites
            .filter { !$0.isEmpty }
            .take(1)
            .withUnretained(self)
            .flatMap { useCase, favoritesList in
                Observable.combineLatest(
                    favoritesList
                        .map {
                            $0.busStopId
                        }
                        .removeDuplicated()
                        .map { busStopId in
                            useCase.busStopArrivalInfoRepository
                                .fetchArrivalList(
                                    busStopId: busStopId
                                )
                        }
                )
            }
            .withLatestFrom(
                favoritesRepository.favorites
            ) { responses, favoritesList in
                (responses, favoritesList)
            }
            .withUnretained(self)
            .subscribe(
                onNext: { useCase, tuple in
                    let (responses, favoritesList) = tuple
                    let result = responses
                        .updateFavoritesStatus(
                            favoritesList: favoritesList
                        )
                        .map { response in
                            response.filterUnfavoritesBuses()
                        }
                    useCase.busStopArrivalInfoResponse.onNext(result)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func bindFavorites() {
        favoritesRepository.favorites
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .withUnretained(self)
            .flatMap { useCase, favoritesList in
                Observable.combineLatest(
                    favoritesList
                        .map {
                            $0.busStopId
                        }
                        .removeDuplicated()
                        .map { busStopId in
                            useCase.busStopArrivalInfoRepository
                                .fetchArrivalList(
                                    busStopId: busStopId
                                )
                        }
                )
            }
            .withLatestFrom(
                favoritesRepository.favorites
            ) { responses, favoritesList in
                (responses, favoritesList)
            }
            .withUnretained(self)
            .subscribe(
                onNext: { useCase, tuple in
                    let (responses, favoritesList) = tuple
                    let result = responses
                        .updateFavoritesStatus(
                            favoritesList: favoritesList
                        )
                        .map { response in
                            response.filterUnfavoritesBuses()
                        }
                    useCase.busStopArrivalInfoResponse.onNext(result)
                }
            )
            .disposed(by: disposeBag)
    }
}
