//
//  LoginViewModal.swift
//  FirstTutorial
//
//  Created by TransData on 26/09/2023.
//

import Foundation
import Combine

class LoginViewModal: ObservableObject {
    @Published var isFetching = false
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @MainActor
    func signIn() {
        print("email is \(email)")
        print("password is \(password)")
    }
}
