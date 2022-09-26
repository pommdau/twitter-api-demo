//
//  AuthAPIError.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/26.
//

import Foundation

enum AuthAPIError: Error, Hashable {
    case login
    case network
    case server
    case system
    case unknown
    
    var title: String {
        switch self {
        case .login:
            return "ログインエラー"
        case .network:
            return "ネットワークのエラー"
        case .server:
            return "サーバエラー"
        case .system:
            return "システムエラー"
        case .unknown:
            return "不明なエラー"
        }
    }
    
    var guidance: String {
        switch self {
        case .login:
            return "IDまたはパスワードが正しくありません"
        case .network:
            return "ネットワークのエラーが発生しました"
        case .server:
            return "サーバのエラーが発生しました"
        case .system:
            return "システムのエラーが発生しました"
        case .unknown:
            return "不明なエラーが発生しました"
        }
    }
}
