//
//  UserViewModel.swift
//  CombineFrameworkFeildValidation
//
//  Created by Gagan Vishal on 2019/09/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    //1.
    @Published var userName = ""
    @Published var password = ""
    @Published var rePasswordEntry = ""
    
    //2.
    @Published var usernameMessage = ""
    @Published var passwordMessage = ""
    var isValidEntry = false
    var cancellableSet: Set<AnyCancellable> = []
    
    //3. Password empty state validator
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { item  in
               return item == ""
            }
           .eraseToAnyPublisher()
    }
    
    //4. Check two passwords are equal
    private var isPasswordsAreEqual: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password,$rePasswordEntry)
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .map { (password, rePasswordEntry) in
                return password == rePasswordEntry
            }
            .eraseToAnyPublisher()
    }
    
    //5. Check password strength
    private var passwordStregthValidator: AnyPublisher<PasswordStength, Never> {
        $password
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [unowned self] item in
                return self.isValidPassword()
            }
            .eraseToAnyPublisher()
    }
    
    //6. Strong password validator
    private var isEnoughPasswordValidator: AnyPublisher<Bool, Never> {
        passwordStregthValidator
            .map { strength in
                switch strength {
                case .normal, .strong:
                    return true
                case .notGood:
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    //7. Put all password validator together
    private var isValidPasswordValidator: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordsAreEqual, isEnoughPasswordValidator)
            .map { (isEmpty, isEqual, isStrong)  in
                if isEmpty {
                    return .isEmpty
                }
                else if !isEqual {
                    return .isNoMatch
                }
                else if !isStrong {
                    return .isNotStrongEnough
                }
                else {
                    return .isValid
                }
            }
        .eraseToAnyPublisher()
    }
    
    //8. Valid name check publosher
    private var isValidUserNamePublisher: AnyPublisher<Bool, Never> {
        $userName
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { items  in
                return items.count > 3
            }
            .eraseToAnyPublisher()
    }
    
    //9. Combine Username & password validatore
    private var isValidFormValidator: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidUserNamePublisher, isValidPasswordValidator)
            .map { (isValidName, isValidPassword)  in
                return isValidName &&  (isValidPassword == .isValid)
             }
            .eraseToAnyPublisher()
    }
    
    
    //MARK:- Init
    init() {
        isValidUserNamePublisher
            .receive(on: RunLoop.main)
            .map { isValid  in
                return isValid ? "" : "Username must be three character long"
            }
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet)
        
        isValidPasswordValidator
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch  passwordCheck {
                case .isEmpty:
                    return "Password field can't be empty."
                case .isNoMatch:
                    return "Pasword does not match."
                case .isNotStrongEnough:
                    return "Password is not strong enough."
                case .isValid:
                    return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        isValidFormValidator
            .receive(on: RunLoop.main)
            .assign(to: \.isValidEntry, on: self)
            .store(in: &cancellableSet)
    }
    
    //MARK:-PASWWORD validation. One upper case, One Numeric, One Special, Minimum SIX charaters
    fileprivate func isValidPassword() -> PasswordStength {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let boolItem = NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        if !boolItem {
            return PasswordStength(rawValue: "notGood")!
        }
        if password.count <= 8 {
            return PasswordStength(rawValue: "normal")!
        }
        return PasswordStength(rawValue: "strong")!
    }
    
    enum PasswordStength: String {
        case notGood = "notGood"
        case normal = "normal"
        case strong = "strong"
    }
    
    enum PasswordCheck {
        case isEmpty
        case isNoMatch
        case isNotStrongEnough
        case isValid
    }
}
