//
//  TwitterAPIRequestProtocol.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

protocol TwitterAPIRequestProtocol {
    associatedtype Response: Decodable
    
    var baseURL    : URL                         { get }
    var path       : String                      { get }  // baesURLからの相対パス
    var method     : HTTPMethod                  { get }
    var queryItems : [URLQueryItem]              { get }
    var header     : Dictionary<String, String>? { get }
    var body       : Data?                       { get }  // HTTP bodyに設定するパラメータ
}

extension TwitterAPIRequestProtocol {
    // GitHubRequestに準拠した型 -> URLRequest型へ変換するためのメソッド
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var urlRequest = URLRequest(url: url)
        
        // クエリ・ヘッダの設定
        components?.queryItems = queryItems  // クエリの追加
        if let header = header {
            for (key, value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        // ボディの設定
        if let body = body {
            urlRequest.httpBody = body
        }
        
        urlRequest.url = components?.url  // URLComponents型からURL型を取得。これにより適切なエンコードを施したクエリ文字列が付与される
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}

