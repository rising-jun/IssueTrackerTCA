//
//  MainCore.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/07/29.
//

import ComposableArchitecture
import Dependencies
import Foundation

struct MainCore: ReducerProtocol {
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        let code: String? = nil
        
    }
    
    enum Action: Equatable {
        case destination(PresentationAction<Destination.Action>)
        case onAppear
        case showList
        case receiveCode(String)
    }
    
    
    @Dependency(\.userDefaultsClient) private var userDefaultsClient
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.destination = .loginView(.init())
                return .none
                
            case .receiveCode(let code):
                userDefaultsClient.saveUserCode(code)
                return .run { send in
                    await send(.showList)
                }
                
            case .showList:
                state.destination = .listView(.init())
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(
            \.$destination,
             action: /Action.destination
        ) {
            Destination()
        }
    }
}

extension MainCore {
    struct Destination: ReducerProtocol {
        enum State: Equatable {
            case loginView(LoginCore.State)
            case listView(ListCore.State)
        }
        
        enum Action: Equatable {
            case loginView(LoginCore.Action)
            case listView(ListCore.Action)
        }
        
        var body: some ReducerProtocolOf<Self> {
            Scope(
                state: /State.loginView,
                action: /Action.loginView
            ) {
                LoginCore()
            }
            Scope(
                state: /State.listView,
                action: /Action.listView
            ) {
                ListCore()
            }
        }
    }
}
