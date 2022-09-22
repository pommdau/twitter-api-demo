//
//  User.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/22.
//

import Foundation

struct User: Identifiable, Sendable {
    let id: ID
    let nickname: String
    let birthday: Date
    
    struct ID: Hashable, Sendable {
        let rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
