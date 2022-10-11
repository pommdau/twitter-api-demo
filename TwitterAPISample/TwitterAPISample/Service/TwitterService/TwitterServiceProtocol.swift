//
//  TwitterServiceProtocol.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

protocol TwitterServiceProtocol {
    func request<Request>(with request: Request) async throws -> Request.Response where Request: TwitterAPIRequestProtocol
}

extension TwitterServiceProtocol {
    func request<Request>(with request: Request) async throws -> Request.Response where Request: TwitterAPIRequestProtocol {
        let request = request.buildURLRequest()
        let decorder = JSONDecoder()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {

            // DEBUGGING
            let errorString = String(data: data, encoding: .utf8)!
            print(errorString)
            
            throw TwitterAPIServiceError.responseError
        }
        
        do {
            let responseString = String(data: data, encoding: .utf8)!
            print(responseString)
            return try decorder.decode(Request.Response.self, from: data)
        } catch {
            throw TwitterAPIServiceError.parseError(error)
        }
    }
}
