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
        case receiveCode(String)
    }
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.destination = .loginView(.init())
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
    
    func sendCode(code: String) {
        
    }
}



extension MainCore {
    struct Destination: ReducerProtocol {
        enum State: Equatable {
            case loginView(LoginCore.State)
        }
        
        enum Action: Equatable {
            case loginView(LoginCore.Action)
        }
        
        var body: some ReducerProtocolOf<Self> {
            Scope(
                state: /State.loginView,
                action: /Action.loginView
            ) {
                LoginCore()
            }
        }
    }
}
