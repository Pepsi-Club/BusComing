//
//  AppstoreRepository.swift
//  Domain
//
//  Created by Jisoo HAM on 8/1/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import RxSwift

public protocol AppstoreRepository {
    func latestVersion() -> Observable<AppInfoResponse>
}
