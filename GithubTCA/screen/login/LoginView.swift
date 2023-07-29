//
//  LoginView.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/07/01.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @State var id: String = ""
    @State var password: String = ""
    
    let store: StoreOf<Login>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack(alignment: .top) {
                Color(UIColor.lightGray).ignoresSafeArea()
                VStack(spacing: 0) {
                    Text("ISSUE TRACKER")
                        .font(.system(size: 44))
                        .padding([.leading, .trailing], 15)
                        .padding(.top, 170)
                    
                    textInputView(title: "아이디", value: $id)
                        .padding(.top, 70)
                    Divider()
                    textInputView(title: "비밀번호", value: $password)
                    
                    ZStack {
                        Button("로그인") {
                            viewStore.send(.loginButtonTapped(LoginInfo(id: id, password: password)))
                        }.padding(.trailing, 150)
                        
                        Button("회원가입") {
                            viewStore.send(.joinButtonTapped)
                        }.padding(.leading, 150)
                    }
                    .padding(.top, 50)
                    
                    VStack {
                        Button {
                            viewStore.send(.githubLoginButtonTapped)
                        } label: {
                            Image("githublogin")
                                .resizable()
                                .padding(.horizontal, 20)
                                .scaledToFit()
                        }
                                            
                        Button {
                            viewStore.send(.appleLoginButtonTapped)
                        } label: {
                            Image("applelogin")
                                .resizable()
                                .padding(.horizontal, 20)
                                .scaledToFit()
                        }
                        .padding(.top, 10)
                    }.padding(.top, 150)
                }
            }
        }
    }
}

@ViewBuilder
func textInputView(title: String, value: Binding<String>) -> some View {
    ZStack(alignment: .leading) {
        HStack {
            Text("\(title)")
                .font(.system(size: 15))
                .padding(.vertical, 15)
                .padding(.leading, 20)
            Spacer()
        }.overlay {
            TextField("abc", text: value)
                .padding(.leading, 100)
                .font(.system(size: 15))
        }
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: Login.State()) {
            Login()
        })
    }
}
