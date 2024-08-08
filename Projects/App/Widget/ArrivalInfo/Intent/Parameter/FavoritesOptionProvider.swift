//
//  FavoritesOptionProvider.swift
//  AppUITests
//
//  Created by gnksbm on 4/13/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import AppIntents

import CoreDataService
import Domain

import RxSwift

struct FavoritesOptionProvider: DynamicOptionsProvider {
    private let coreDataService = DefaultCoreDataService()
    
    private let disposeBag = DisposeBag()
    
    func defaultResult() async -> String? {
        nil
    }
    
    func results() async throws -> [String] {
        
        return await withCheckedContinuation { continuation in
            coreDataService.fetch(
                type: FavoritesBusResponse.self
            )
            .map { responses in
                responses.map { response in
                    "\(response.busStopName), \(response.busName)"
                }
            }
            .subscribe(
                onNext: { result in
                    continuation.resume(returning: result)
                }
            )
            .disposed(by: disposeBag)
        }
    }
}
