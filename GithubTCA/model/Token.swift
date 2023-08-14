//
//  Token.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/08/05.
//

import Foundation


struct Token: Decodable {
    let accessToken: String
    let scope: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case tokenType = "token_type"
    }
}
