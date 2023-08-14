//
//  GithubAPI.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/08/03.
//

import Foundation

enum GithubAPI {
    private var clientID: String {
        return "2ca00a62da0566df46d7"
    }
    
    private var clientSecret: String {
        return "1c89a6a4c8e41713dae3cfc06311482ad78e526c"
    }
    
    case exchangeToken(String)
    case requestIssueList
}

extension GithubAPI {
    var baseURL: URL {
        switch self {
        case .exchangeToken(_):
            return URL(string: "https://github.com")!
        case .requestIssueList:
            return URL(string: "https://api.github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .exchangeToken(_):
            return "/login/oauth/access_token"
        case .requestIssueList:
            return "/repos/rising-jun/issue-tracker/issues"
        }
    }
    
    var method: Method {
        switch self {
        case .exchangeToken(_):
            return .post
        case .requestIssueList:
            return .get
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .exchangeToken(let code):
            return [
                "client_id": clientID,
                "client_secret": clientSecret,
                "code": code
            ]
        default:
            return nil
        }
    }
    
    var parameterValue: Data? {
        return try? JSONSerialization.data(withJSONObject: parameter ?? [:])
    }
    
    var headers: [String: String]? {
        switch self {
        case .exchangeToken(_):
            return ["Content-Type": "application/json",
                    "Accept": "application/json"]
        case .requestIssueList:
            return ["Accept": "application/vnd.github.v3+json"]
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        let decodedObject = try decoder.decode(type, from: data)
        return decodedObject
    }
}

enum Method {
    case post
    case get
    case delete
    case update
    case patch
    
    var value: String {
        switch self {
        case .post:
            return "POST"
        case .get:
            return "GET"
        case .delete:
            return "DELETE"
        case .update:
            return "UPDATE"
        case .patch:
            return "PATCH"
        }
    }
}
