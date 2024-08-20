//
//  AppInfoResponse.swift
//  Domain
//
//  Created by Jisoo HAM on 8/1/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

public struct AppInfoResponse {
    let resultCount: Int
    let results: [AppDetailResponse]
    
    public init(resultCount: Int, results: [AppDetailResponse]) {
        self.resultCount = resultCount
        self.results = results
    }
}

public struct AppDetailResponse: Decodable {
    let releaseNotes: String
    let releaseDate: String
    let version: String
    
    public init(releaseNotes: String, releaseDate: String, version: String) {
        self.releaseNotes = releaseNotes
        self.releaseDate = releaseDate
        self.version = version
    }
}
