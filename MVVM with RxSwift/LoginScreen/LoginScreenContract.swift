//
//  LoginScreenProtocol.swift
//  MVVM with RxSwift
//
//  Created by admin on 03.08.2021.
//

import RxSwift
import RxCocoa

protocol LoginScreenViewModelProtocol {
    func checkValidation(text: String,type: RegexValidationType) -> Bool
    func updateText(for type: RowType, text: String)
    func validateAll()
    func updateMessageLabel(type: RowType) -> String
    var buttonActivityEvent: Driver<Bool> { get }
}

protocol LoginScreenModelProtocol {
    var loginTextValue: String { get set }
    var passwordTextValue: String { get set }
}

enum RowType {
    case login
    case password
}
