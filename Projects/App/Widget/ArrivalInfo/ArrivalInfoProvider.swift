//
//  ArrivalInfoProvider.swift
//  AppUITests
//
//  Created by gnksbm on 4/4/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import SwiftUI
import WidgetKit

import Core
import Domain

import RxSwift

@available(iOS 17.0, *)
struct ArrivalInfoProvider: AppIntentTimelineProvider {
    
    public let disposeBag = DisposeBag()
    private let networkService = WidgetNetworkService()
    
    /// 위젯이 로드되는 동안 표시할 기본적인 플레이스홀더 뷰
    func placeholder(in context: Context) -> ArrivalInfoEntry {
        ArrivalInfoEntry(
            date: Date(),
            configuration: ArrivalInfoIntent(),
            responses: []
        )
    }
    
    /// 위젯 선택시 보여주는 뷰
    func snapshot(
        for configuration: ArrivalInfoIntent,
        in context: Context
    ) async -> ArrivalInfoEntry {
        ArrivalInfoEntry(
            date: Date(),
            configuration: configuration,
            responses: .mock
        )
    }
    
    func timeline(
        for configuration: ArrivalInfoIntent,
        in context: Context
    ) async -> Timeline<ArrivalInfoEntry> {
        let entry = ArrivalInfoEntry(
            date: Date(),
            configuration: configuration,
            responses: []
        )
        return Timeline(
            entries: [entry],
            policy: .never
        )
    }
}
