//
//  NetworkError.swift
//  Network
//
//  Created by gnksbm on 2023/12/27.
//  Copyright © 2023 Pepsi-Club. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case jsonSerializationError(Error)
    case transportError(Error)
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidData
    case parseError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .jsonSerializationError(let error):
            return "JSON 직렬화 에러: \(error.localizedDescription)"
        case .transportError(let error):
            return "네트워크 요청 에러: \(error.localizedDescription)"
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .invalidStatusCode(let code):
            return "서버 응답 코드 에러: \(code)"
        case .invalidData:
            return "유효하지 않은 데이터입니다."
        case .parseError:
            return "데이터 파싱에 실패하였습니다."
        }
    }
}
