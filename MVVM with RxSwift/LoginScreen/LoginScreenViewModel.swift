//
//  LoginScreenViewModel.swift
//  MVVM with RxSwift
//
//  Created by admin on 02.08.2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class LoginScreenViewModel {
    private var model: LoginScreenModelProtocol
    private var validationManager: ValidationManagerProtocol
    private var regexValidation: RegexValidationProtocol
    private let buttonActivity = PublishSubject<Bool>()
    
    init(model: LoginScreenModelProtocol, validationManager: ValidationManagerProtocol, regexValidation: RegexValidationProtocol) {
        self.model = model
        self.validationManager = validationManager
        self.regexValidation = regexValidation
    }
}

extension LoginScreenViewModel: LoginScreenViewModelProtocol {    
    var buttonActivityEvent: Driver<Bool> { buttonActivity.asDriver(onErrorJustReturn: false) }
    
    func updateText(for type: RowType, text: String) {
        switch type {
        case .login: model.loginTextValue = text
        case .password: model.passwordTextValue = text
        }
    }
    
    func validateAll(){
        let statusValidation = validationManager.validation(text: model.loginTextValue).isEmpty && validationManager.validation(text: model.passwordTextValue).isEmpty
        buttonActivity.onNext(statusValidation)
    }
    
    func checkValidation(text: String,type: RegexValidationType) -> Bool {
        return regexValidation.validationText(text: text, type: type)
    }
    
    func updateMessageLabel(type: RowType) -> String {
        switch type {
        case .login:
            let loginValidationStatus = validationManager.validation(text: model.loginTextValue)
            return loginValidationStatus
        case .password:
            let passwordValidationStatus = validationManager.validation(text: model.passwordTextValue)
            return passwordValidationStatus
        }
    }
}


