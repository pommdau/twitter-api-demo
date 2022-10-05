//
//  AuthServiceError.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/26.
//

import Foundation

enum AuthServiceError : Error {
    // 通信に失敗
    case connectionError(Error)
    
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    
    // APIからエラーレスポンスを受け取った
    case apiError(AuthAPIError)
    
    // response as? HTTPURLResponseに失敗
    case httpURLResponseCastError
    
    case others(Error)
    
    var title: String {
        switch self {
        case .connectionError(_):
            return "通信エラー"
        case .responseParseError(_):
            return "レスポンス処理エラー"
        case .apiError(_):
            return "APIエラー"
        case .httpURLResponseCastError:
            return "HTTP処理エラー"
        case .others(_):
            return "その他のエラー"
        }
    }
    
    // TODO: fix it
    var guidance: String {
        switch self {
        case .connectionError(_):
            return ""
        case .responseParseError(_):
            return ""
        case .apiError(_):
            return ""
        case .httpURLResponseCastError:
            return ""
        case .others(_):
            return ""
        }
    }
            
}
