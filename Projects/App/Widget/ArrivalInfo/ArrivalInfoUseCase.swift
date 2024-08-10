//
//  ArrivalInfoUseCase.swift
//  App
//
//  Created by gnksbm on 4/8/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import WidgetKit
import AppIntents

import Domain

import RxSwift

@available(iOS 17.0, *)
final class ArrivalInfoUseCase {
    var responses = [BusStopArrivalInfoResponse]()
    private let disposeBag = DisposeBag()
    private let networkService = WidgetNetworkService()
    
    func fetchUserDefaultValue() {
//        guard let datas
//         = UserDefaults.appGroup.array(forKey: "arrivalResponse") as? [Data]
//        else {
//            return
//        }
//        responses = datas.compactMap {
//            return try? 
//            JSONDecoder().decode(BusStopArrivalInfoResponse.self, from: $0)
//        }
    }
    
    func updateArrivalInfo(
        busStopId: String,
        completion: @escaping ([BusStopArrivalInfoResponse])
        -> Void
    ) {
        networkService.fetchArrivalList(busStopId: busStopId)
            .subscribe(
                onNext: { [weak self] response in
                    self?.responses = [response]
                    completion([response])
                },
                onError: { error in
                    print("Error fetching data: \(error)")
                    completion([])
                }
            )
            .disposed(by: disposeBag)
    }
    
// 여기에서 반환한 값을 ArrivalInfoEntry.reponses에 적용을 해야
// 전체적으로 fetch가 돼서 widget View에 적용되는것 아닌지,,,모르겠음
     func fetchResponses(busStopId: String?) async ->
    [BusStopArrivalInfoResponse] {
        return await
        withCheckedContinuation { continuation in
            networkService.fetchArrivalList(busStopId: busStopId ?? "")
                .subscribe(
                    onNext: { response in
                        continuation.resume(returning: [response])
                    },
                    onError: { error in
                        print("Error fetching data: \(error)")
                        continuation.resume(returning: [])
                    }
                )
                .disposed(by: disposeBag)
        }
    }
}
