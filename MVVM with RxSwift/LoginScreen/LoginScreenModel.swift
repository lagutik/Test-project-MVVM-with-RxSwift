//
//  LoginScreenModel.swift
//  MVVM with RxSwift
//
//  Created by admin on 02.08.2021.
//

class LoginScreenModel {
    private var loginText: String?
    private var passwordText: String?
}

extension LoginScreenModel: LoginScreenModelProtocol {
    var loginTextValue: String {
           get { loginText ?? "" }
           set { loginText = newValue }
       }

    var passwordTextValue: String {
        get { passwordText ?? "" }
        set { passwordText = newValue }
    }
}
