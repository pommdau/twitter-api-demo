//
//  TwitterAPIResponse+Login.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

extension TwitterAPIResponse {
    
    struct Login {
        let state: String
        let code: String
                        
        init?(queryItems: [URLQueryItem]) {
            
            var state: String? = nil
            var code: String? = nil
            
            for queryItem in queryItems {
                switch queryItem.name {
                case "state":
                    state = queryItem.value
                case "code":
                    code = queryItem.value
                default:
                    return nil
                }
            }
            
            guard let state = state,
                  let code = code else {
                return nil
            }
            
            self.state = state
            self.code = code
        }
    }
}
