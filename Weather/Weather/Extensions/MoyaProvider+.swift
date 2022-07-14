//
//  MoyaProvider+.swift
//  Weather
//
//  Created by 김태훈 on 2022/07/12.
//

import Foundation
import Combine
import Moya
import CombineMoya

extension MoyaProvider {
    func request<T: Decodable>(target: Target,
                 callbackQueue: DispatchQueue? = nil) -> AnyPublisher<T?, Never> {
        let startTime = DispatchTime.now()
        return self.requestPublisher(target,
                                     callbackQueue: callbackQueue)
        .map { response -> T? in
            Self.log(target: target, response: response, startTime: startTime)
            let decodeResponse: T? = response.decode()
            return decodeResponse
        }
        .assertNoFailure()
        .eraseToAnyPublisher()
    }
}

private extension MoyaProvider {
    static func log(target: Target,
                    response: Response,
                    startTime: DispatchTime) {
        print("")
        NSLog("[Weather API] method: \(target.method)")
        NSLog("[Weather API] url: \(response.request?.url?.absoluteString ?? "no url")")
        NSLog("[Weather API] task: \(target)")
        NSLog("[Weather API] statusCode: " + String(response.statusCode))
        NSLog("[Weather API] response: " + (String(data: response.data,
                                                       encoding: .utf8) ?? "no data"))
        NSLog("[Weahter API] spend: " + "\(startTime.distance(to: .now())) s")
        print("")
    }
}

fileprivate extension Response {
    func decode<T: Decodable>() -> T? {
        try? self.data.asDecodable()
    }
}

extension Data {
    func asDecodable<T: Decodable>() throws -> T {
        do {
            print("DECODE: Parsed type is: \(T.self)")
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: self)
        } catch {
            print("ERROR: " + error.localizedDescription + "\n Data: " + (String(data: self, encoding: .utf8) ?? ""))
            throw error
        }
    }
}
