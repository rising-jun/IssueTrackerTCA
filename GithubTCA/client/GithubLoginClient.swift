//
//  GithubLoginRequest.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/07/02.
//

import Foundation
import Dependencies

struct GithubLoginClient {
    var getURL: () -> URL?
    var exchangeTokenByCode: (String) async throws -> String
}
extension GithubLoginClient: DependencyKey {
    static var liveValue = GithubLoginClient {
        let clientID = "2ca00a62da0566df46d7"
        let clientSecret = "1c89a6a4c8e41713dae3cfc06311482ad78e526c"
        let scope = "login"
        let urlString = "https://github.com/login/oauth/authorize"
        guard var components = URLComponents(string: urlString) else { return nil }
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "scope", value: scope)
        ]
        return components.url
    } exchangeTokenByCode: { code in
        let api = GithubAPI.exchangeToken(code)
        var urlRequest = URLRequest(url: api.baseURL)
        urlRequest.httpBody = api.parameterValue
        urlRequest.httpMethod = api.method.value
        let data = try await URLSession.shared.data(for: urlRequest).0
        let token: Token = try api.decodeJSON(type: Token.self, from: data)
        return token.accessToken
    }
}

extension DependencyValues {
    var githubLoginClient: GithubLoginClient {
        get { self[GithubLoginClient.self] }
        set { self[GithubLoginClient.self] = newValue }
      }
}
