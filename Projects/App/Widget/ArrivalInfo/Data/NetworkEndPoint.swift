//
//  NetworkEndPoint.swift
//  Widget
//
//  Created by 유하은 on 8/8/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

public protocol EndPoint {
    var scheme: Scheme { get }
    var host: String { get }
    var port: String { get }
    var path: String { get }
    var query: [String: String] { get }
    var header: [String: String] { get }
    var body: [String: Any] { get }
}

public enum Scheme: String {
    case http, https
}

extension EndPoint {
    public var toURLRequest: URLRequest? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme.rawValue
        urlComponent.host = host
        urlComponent.port = Int(port)
        urlComponent.path = path
        if !query.isEmpty {
            urlComponent.queryItems = query.map {
                .init(name: $0.key, value: $0.value)
            }
        }
        guard let urlStr = urlComponent.url?.absoluteString
            .replacingOccurrences(of: "%25", with: "%"),
              let url = URL(string: urlStr)
        else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = header
        if !body.isEmpty {
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: body)
                urlRequest.httpBody = httpBody
            } catch {
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
        return urlRequest
    }
}
