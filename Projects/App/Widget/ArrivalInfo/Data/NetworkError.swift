//
//  NetworkError.swift
//  Widget
//
//  Created by 유하은 on 8/8/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case transportError(Error)
    case invalidStatusCode(Int)
    case invalidData
    case invalidURL
    case parseError
    
    var errorDescription: String? {
        switch self {
        case .transportError(let error):
            return "에러: \(error.localizedDescription)"
        case .invalidStatusCode(let code):
            return "서버 응답 코드 에러: \(code)"
        case .invalidData:
            return "유효하지 않은 데이터입니다."
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .parseError:
            return "데이터 파싱에 실패하였습니다."
        }
    }
}
