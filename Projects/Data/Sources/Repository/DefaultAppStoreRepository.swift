//
//  DefaultAppStoreRepository.swift
//  Data
//
//  Created by Jisoo HAM on 8/1/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import UIKit

import Domain
import NetworkService

import RxSwift

enum AppStoreError: Error, LocalizedError {
    case invalidAppStoreId
    case invalidURL
    case noData
    case parsingError
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidAppStoreId:
            "AppStore Id 잘못됨"
        case .invalidURL:
            "AppStore URL 잘못됨"
        case .noData:
            "Data 잘못됨"
        case .parsingError:
            "데이터 parsing 잘못됨"
        case .networkError(let error):
            "\(error) 네트워크 에러"
        }
    }
}

public final class DefaultAppStoreRepository: AppstoreRepository {
    private let networkService: NetworkService
    private let appStoreId = Bundle.main
        .object(forInfoDictionaryKey: "APPSTORE_ID") as? String
    
    public let appStoreURLString
    = "itms-apps://itunes.apple.com/app/apple-store/"
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func latestVersion() -> Observable<AppInfoResponse> {
        guard let appStoreId else {
            return Observable.error(AppStoreError.invalidAppStoreId)
        }
        let data = networkService.request(
            endPoint: AppStoreEndPoint(appStoreID: appStoreId)
        )
            .decode(
                type: AppInfoDTO.self,
                decoder: JSONDecoder()
            )
            .compactMap { $0.toDomain }
        return data
    }
    
    public func openAppStore() {
        guard let appStoreId,
              let url = URL(
                string: appStoreURLString + appStoreId
              )
        else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
