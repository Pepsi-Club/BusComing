//
//  ArrivalInfoNetworkService.swift
//  Widget
//
//  Created by 유하은 on 8/8/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import Foundation

import Domain

import RxSwift

public final class WidgetNetworkService {
    private let widgetNetworkService = WidgetNetworkService()
    private let disposeBag = DisposeBag()
    
    public init() { }

    public func request(endPoint: EndPoint) -> Observable<Data> {
        .create { observer in
            guard let urlRequest = endPoint.toURLRequest
            else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(
                with: urlRequest
            ) { data, response, error in
                if let error {
                    observer.onError(NetworkError.transportError(error))
                    return
                }
                
                guard let httpURLResponse = response as? HTTPURLResponse
                else { return }
                guard 200..<300 ~= httpURLResponse.statusCode
                else {
                    observer.onError(
                        NetworkError.invalidStatusCode(
                            httpURLResponse.statusCode
                        )
                    )
                    #if DEBUG
                    if let url = urlRequest.url,
                       let httpMethod = urlRequest.httpMethod,
                       let data = urlRequest.httpBody,
                       let httpBody = String(
                        data: data,
                        encoding: .utf8
                       ) {
                        print(
                            url,
                            httpMethod,
                            httpBody,
                            separator: "\n"
                        )
                    }
                    if let data,
                       let json = String(
                        data: data,
                        encoding: .utf8
                       ) {
                        print(
                            json
                        )
                    }
                    #endif
                    return
                }
                
                guard let data
                else {
                    observer.onError(NetworkError.invalidData)
                    return
                }
                observer.onNext(data)
                observer.onCompleted()
            }.resume()
            
            return Disposables.create()
        }
    }
    
    // 이 함수 return 부분 코드 컨벤션 고민 
    public func fetchArrivalList(busStopId: String) ->
    Observable<BusStopArrivalInfoResponse> {
    
    return
        request(endPoint: BusStopArrivalInfoEndPoint(arsId: busStopId))
            .decode(type: BusStopArrivalInfoDTO.self, 
                    decoder: JSONDecoder())
            .compactMap { $0.toDomain }
        }
}
