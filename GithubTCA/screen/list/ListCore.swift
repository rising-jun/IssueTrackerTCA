//
//  ListCore.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/08/12.
//

import Foundation
import ComposableArchitecture

struct ListCore: ReducerProtocol {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case onAppear
    }
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
