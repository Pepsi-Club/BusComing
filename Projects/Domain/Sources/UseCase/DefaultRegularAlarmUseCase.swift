//
//  DefaultRegularAlarmUseCase.swift
//  Domain
//
//  Created by gnksbm on 3/10/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import RxSwift

public class DefaultRegularAlarmUseCase: RegularAlarmUseCase {
    private let localNotificationService: LocalNotificationService
    private let regularAlarmRepository: RegularAlarmRepository
    
    public let fetchedAlarm = PublishSubject<[RegularAlarmResponse]>()
    private let disposeBag = DisposeBag()
    
    public init(
        localNotificationService: LocalNotificationService,
        regularAlarmRepository: RegularAlarmRepository
    ) {
        self.localNotificationService = localNotificationService
        self.regularAlarmRepository = regularAlarmRepository
    }
    
    public func fetchAlarm() {
        regularAlarmRepository.currentRegularAlarm
            .withUnretained(self)
            .map { useCase, responses in
                useCase.sortResponses(responses: responses)
            }
            .bind(to: fetchedAlarm)
            .disposed(by: disposeBag)
        migrateRegularAlarm()
    }
    
    public func removeAlarm(response: RegularAlarmResponse) throws {
        regularAlarmRepository.deleteRegularAlarm(response: response) {
            print("Remove completed")
        }
    }
    
    public func migrateRegularAlarm() {
        localNotificationService.fetchRegularAlarm()
            .filter { !$0.isEmpty }
            .withUnretained(self)
            .subscribe(
                onNext: { useCase, responses in
                    responses.forEach { response in
                        useCase.regularAlarmRepository.createRegularAlarm(
                            response: response
                        ) {
                            useCase.removeLegacy(response: response)
                        }
                        
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func sortResponses(
        responses: [RegularAlarmResponse]
    ) -> [RegularAlarmResponse] {
        responses.sorted {
            guard let firstValue = $0.weekday.sorted().first,
                  let secondValue = $1.weekday.sorted().first
            else { return true }
            let dateResult = $0.time < $1.time
            let weekDayResult = firstValue < secondValue
            return firstValue == secondValue ?
            dateResult : weekDayResult
        }
    }
    
    private func removeLegacy(response: RegularAlarmResponse) {
        do {
            try localNotificationService.removeRegularAlarm(response: response)
        } catch {
            print(error.localizedDescription)
        }
    }
}
