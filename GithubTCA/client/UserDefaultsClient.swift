//
//  UserDefaultClient.swift
//  GithubTCA
//
//  Created by 김동준 on 2023/08/14.
//

import Foundation
import Dependencies

struct UserDefaultsClient {
    var saveUserCode: (String) -> Void
}
extension UserDefaultsClient: DependencyKey {
    static var liveValue = UserDefaultsClient { code in
        UserDefaults.standard.set(code, forKey: UserDefaults.Keys.code.value)
    }
}

extension DependencyValues {
    var userDefaultsClient: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }
}

extension UserDefaults {
    enum Keys {
        case code
        
        var value: String {
            switch self {
            case .code:
                return "code"
            }
        }
    }
}
