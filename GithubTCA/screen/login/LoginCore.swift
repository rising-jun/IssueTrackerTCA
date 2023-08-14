//
//  Login.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/07/01.
//

import ComposableArchitecture
import Dependencies
import Foundation

struct LoginCore: ReducerProtocol {
    
    struct State: Equatable { }
    
    enum Action: Equatable {
        case loginButtonTapped(LoginInfo)
        case joinButtonTapped
        case githubLoginButtonTapped
        case appleLoginButtonTapped
    }
    
    @Dependency(\.openURL) var urlOpener
    @Dependency(\.githubLoginClient) var githubLoginClient
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .loginButtonTapped(_):
                return .none
            case .joinButtonTapped:
                return .none
            case .githubLoginButtonTapped:
                return .run { @MainActor _ in
                    guard let url = githubLoginClient.getURL() else { return }
                    await urlOpener(url) 
                }
            case .appleLoginButtonTapped:
                return .none
            }
        }
    }
}
