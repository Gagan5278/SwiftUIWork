//
//  ContentView.swift
//  CombineFrameworkFeildValidation
//
//  Created by Gagan Vishal on 2019/09/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var userViewModel = UserViewModel()
    var body: some View {
        Form {
            Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.red)){
                TextField("username", text: $userViewModel.userName)
            }
            Section (footer:  Text(userViewModel.passwordMessage).foregroundColor(.red)){
                SecureField("Enter password", text: $userViewModel.password)
                SecureField("Re-enter your password", text: $userViewModel.rePasswordEntry)
            }
            Section {
                Button(action: {
                    
                }) {
                    Text("Submit form")
                        .multilineTextAlignment(.center)
                }.disabled(!userViewModel.isValidEntry)
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
