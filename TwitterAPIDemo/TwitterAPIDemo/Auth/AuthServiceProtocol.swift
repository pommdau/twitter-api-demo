//
//  AuthServiceProtocol.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/26.
//

import Foundation

protocol AuthServiceProtocol {
    static var shared: Self { get }
    
    func logIn(for id: User.ID, with password: String) async throws
}
