//
//  ListView.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/08/12.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct ListView: View {
    
    let store: StoreOf<ListCore>
    
    var body: some View {
        contents
            .onAppear {
                store.send(.onAppear)
            }
    }
    
    @ViewBuilder
    var contents: some View {
        Text("List"
        )
    }
}
