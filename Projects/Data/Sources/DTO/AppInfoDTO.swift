//
//  AppInfoDTO.swift
//  Data
//
//  Created by Jisoo HAM on 8/1/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import Domain

public struct AppInfoDTO: Decodable {
    let resultCount: Int
    let results: [AppDetailDTO]
}

extension AppInfoDTO {
    var toDomain: AppInfoResponse {
        let results = results.map {
            AppDetailResponse(
                releaseNotes: $0.releaseNotes,
                releaseDate: $0.releaseDate,
                version: $0.version
            )
        }
        return AppInfoResponse.init(
            resultCount: resultCount,
            results: results
        )
    }
}

extension AppInfoDTO {
    struct AppDetailDTO: Decodable {
        let advisories: [String]
        let appletvScreenshotUrls: [String]
        let artistId: Int
        let artistName: String
        let artistViewUrl: String
        let artworkUrl100: String
        let artworkUrl512: String
        let artworkUrl60: String
        let averageUserRating: Double
        let averageUserRatingForCurrentVersion: Double
        let bundleId: String
        let contentAdvisoryRating: String
        let currency: String
        let currentVersionReleaseDate: String
        let description: String
        let features: [String]
        let fileSizeBytes: Int
        let formattedPrice: String
        let genreIds: [String]
        let genres: [String]
        let ipadScreenshotUrls: [String]
        let isGameCenterEnabled: Bool
        let isVppDeviceBasedLicensingEnabled: Bool
        let kind: String
        let languageCodesISO2A: [String]
        let minimumOsVersion: String
        let price: Double
        let primaryGenreId: Int
        let primaryGenreName: String
        let releaseDate: String
        let releaseNotes: String
        let screenshotUrls: [String]
        let sellerName: String
        let supportedDevices: [String]
        let trackCensoredName: String
        let trackContentRating: String
        let trackId: Int
        let trackName: String
        let trackViewUrl: String
        let userRatingCount: Int
        let userRatingCountForCurrentVersion: Int
        let version: String
        let wrapperType: String
    }
}
