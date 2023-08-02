//
//  GithubTCAApp.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/07/01.
//

import SwiftUI
import ComposableArchitecture

@main
struct GithubTCAApp: App {
    private var mainStore = Store(
        initialState: MainCore.State(),
        reducer: MainCore()
    )
    
    var body: some Scene {
        WindowGroup {
            MainView(store: mainStore)
                .onOpenURL { url in
                    let code = url.absoluteString.components(separatedBy: "code=").last ?? ""
                    ViewStore(mainStore).send(.receiveCode(code))
            }
        }
    }
}
