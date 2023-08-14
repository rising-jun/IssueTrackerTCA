//
//  MainView.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/07/29.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct MainView: View {
    
    let store: StoreOf<MainCore>
    
    var body: some View {
        contents
            .onAppear {
                store.send(.onAppear)
            }
            .fullScreenCover(
                store: store.scope(
                    state: \.$destination,
                    action: MainCore.Action.destination ),
                state: /MainCore.Destination.State.loginView,
                action: MainCore.Destination.Action.loginView
            ) { LoginView(store: $0) }
    }
    
    @ViewBuilder
    var contents: some View {
        TabView {
            IfLetStore(
                store.scope(
                    state: \.$destination,
                    action: MainCore.Action.destination
                ),
                state: /MainCore.Destination.State.listView,
                action: MainCore.Destination.Action.listView) {
                    ListView(store: $0)
                }
                .tabItem {
                    Text("List")
                }
        }
    }
}
