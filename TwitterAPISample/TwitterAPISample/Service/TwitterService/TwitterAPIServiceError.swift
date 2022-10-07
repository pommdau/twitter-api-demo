//
//  TwitterAPIServiceError.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

// TODO: connectionErrorとかいらないか確認
enum TwitterAPIServiceError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
}
