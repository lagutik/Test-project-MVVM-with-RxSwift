//
//  RegexPattern.swift
//  MVVM with RxSwift
//
//  Created by admin on 05.08.2021.
//


class RegexValidation: RegexValidationProtocol {
    func validationText(text: String, type: RegexValidationType) -> Bool {
        switch type {
        case .login: return text.matches(type.pattern)
        case .password: return text.matches(type.pattern)
        }
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return (range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil)
    }
}

enum RegexValidationType {
    case password
    case login
    var pattern: String {
        switch self {
        case .login:
            return "^[a-zA-Z0-9._-]{0,20}$"
        case .password:
            return "^[A-Z0-9a-z-+\\/.\"%*=?^_{}()$#!@\\\\;:\\[\\]]{0,16}$"
        }
    }
}
