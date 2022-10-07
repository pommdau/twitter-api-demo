//
//  HTTPMethod.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case head    = "HEAD"
    case delete  = "DELETE"
    case patch   = "PATCH"
    case trace   = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
