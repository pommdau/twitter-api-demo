//
//  AuthAPIError.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/26.
//

import Foundation

// TODO: TwitterAPIのエラー形式に合わせる
public struct AuthAPIError : Decodable, Error {
    public struct Error : Decodable {
        public var resource: String
        public var field: String
        public var code: String
    }
    
    public var message: String  // レスポンスのJSONに必ず含まれる
    public var errors: [Error]
}
