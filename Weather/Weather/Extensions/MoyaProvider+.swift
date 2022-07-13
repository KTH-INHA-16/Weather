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
        return self.requestPublisher(target,
                                     callbackQueue: callbackQueue)
        .map { response -> T? in
            let decodeResponse: T? = response.decode()
            return decodeResponse
        }
        .assertNoFailure()
        .eraseToAnyPublisher()
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
