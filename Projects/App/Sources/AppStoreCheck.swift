//
//  AppStoreCheck.swift
//  App
//
//  Created by Jisoo Ham on 5/26/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import UIKit

import Core
import Domain
import NetworkService

import RxSwift

enum AppStoreError: Error {
    case invalidURL
    case noData
    case parsingError
    case networkError(Error)
}

public final class DefaultAppStoreCheck {
    static let shared = DefaultAppStoreCheck()
    
    private let appstoreID: String?
    
    public let appStoreURLString
    = "itms-apps://itunes.apple.com/app/apple-store/"
    
    private init() {
        appstoreID = Bundle.main.object(forInfoDictionaryKey: "APPSTORE_ID")
        as? String
    }
    
    public func latestVersion() -> Single<String> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(AppStoreError.invalidURL))
                return Disposables.create()
            }
            Task {
                do {
                    guard let appstoreID = self.appstoreID,
                          let urlRequest = AppStoreEndPoint(
                            appStoreID: appstoreID).toURLRequest
                    else {
                        throw AppStoreError.invalidURL
                    }
                    
                    let (data, _) = try await URLSession
                        .shared.data(for: urlRequest)
                    
                    let json = try JSONSerialization.jsonObject(
                        with: data,
                        options: .allowFragments
                    ) as? [String: Any]
                    
                    guard let results = json?["results"] as? [[String: Any]],
                          let appStoreVersion = results.first?["version"]
                            as? String 
                    else {
                        throw AppStoreError.parsingError
                    }
                    
                    single(.success(appStoreVersion))
                    
                } catch let error as AppStoreError {
                    single(.failure(error))
                } catch {
                    single(.failure(AppStoreError.networkError(error)))
                }
            }
            return Disposables.create()
        }
    }
    /// URL을 통해 앱스토어 오픈
    public func openAppStore() {
        guard let appstoreID,
              let url = URL(
                string: appStoreURLString + appstoreID
              )
        else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
