//
//  String+.swift
//  Core
//
//  Created by gnksbm on 2023/12/27.
//  Copyright © 2023 Pepsi-Club. All rights reserved.
//

import UIKit
import CoreLocation

public extension String {
    /**
     String을 Date로 변환
     - Parameters:
        - dateFormat: 변환할 포맷
     - Returns: 포맷된 Date 반환, 소스가 잘못되었을 경우 Date.now 반환
     */
    func toDate(dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = .current
        guard let date = dateFormatter.date(from: self)
        else { return .now }
        return date
    }
    /// 공공 버스 API Key
    static var serverKey: Self {
        guard let any = Bundle.main.object(
            forInfoDictionaryKey: "DATA_GO_KR_API_KEY"
        ),
              let serverKey = any as? String
        else { fatalError("Can't Not Find Server Key") }
        return serverKey
    }
    
    /// 프로젝트 버전
    static func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return "1" }
        return version
    }
    
    static func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier
        = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8,
                  value != 0
            else { return identifier }
            
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone10,1", "iPhone10,4": 
            return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":
            return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":
            return "iPhone X"
        case "iPhone11,2":
            return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":
            return "iPhone XS Max"
        case "iPhone11,8":
            return "iPhone XR"
        case "iPhone12,1":
            return "iPhone 11"
        case "iPhone12,3":
            return "iPhone 11 Pro"
        case "iPhone12,5":
            return "iPhone 11 Pro Max"
        case "iPhone12,8":
            return "iPhone SE (2nd generation)"
        case "iPhone13,1":
            return "iPhone 12 mini"
        case "iPhone13,2":
            return "iPhone 12"
        case "iPhone13,3":
            return "iPhone 12 Pro"
        case "iPhone13,4":
            return "iPhone 12 Pro Max"
        case "iPhone14,4":
            return "iPhone 13 mini"
        case "iPhone14,5":
            return "iPhone 13"
        case "iPhone14,2":
            return "iPhone 13 Pro"
        case "iPhone14,3":
            return "iPhone 13 Pro Max"
        case "iPhone14,6":
            return "iPhone SE (3rd generation)"
        case "iPhone14,7":
            return "iPhone 14"
        case "iPhone14,8":
            return "iPhone 14 Plus"
        case "iPhone15,2":
            return "iPhone 14 Pro"
        case "iPhone15,3":
            return "iPhone 14 Pro Max"
        case "iPhone15,4":
            return "iPhone 15"
        case "iPhone15,5":
            return "iPhone 15 Plus"
        case "iPhone16,1":
            return "iPhone 15 Pro"
        case "iPhone16,2":
            return "iPhone 15 Pro Max"
        default:
            return identifier
        }
    }
    
    static var fcmToken: Self? {
        UserDefaults.standard.string(forKey: "fcmToken")
    }
}
