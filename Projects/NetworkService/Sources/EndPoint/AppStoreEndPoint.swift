//
//  AppStoreEndPoint.swift
//  NetworkService
//
//  Created by Jisoo HAM on 7/31/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

public struct AppStoreEndPoint: EndPoint {
    private let appStoreID: String
    
    public var scheme: Scheme {
        return .https
    }
    public var host: String {
        return "itunes.apple.com"
    }
    public var port: String {
        ""
    }
    public var path: String {
        return "/lookup"
    }
    public var query: [String: String] {
        return [
            "id": appStoreID,
            "country": "kr"
        ]
    }
    public var header: [String: String] {
        return [:]
    }
    public var body: [String: Any] {
        return [:]
    }
    public var method: HTTPMethod {
        return .get
    }
    
    public init(appStoreID: String) {
        self.appStoreID = appStoreID
    }
}
