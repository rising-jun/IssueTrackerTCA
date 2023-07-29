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
    var body: some Scene {
        WindowGroup {
            LoginView(store: Store(initialState: Login.State()) {
                Login()
            }).onOpenURL { url in
                print("opended url \(url)")
            }
        }
    }
}
